import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr To Jokr Tests/"

class AntlrToJokrTests: XCTestCase {

	func getProgram(
		inFile filename: String) throws -> JokrParser.ProgramContext {

		do {
			let contents = try! String(contentsOfFile: testFilesPath + filename)
			let inputStream = ANTLRInputStream(contents)
			let lexer = JokrLexer(inputStream)
			let tokens = CommonTokenStream(lexer)
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			return try parser.program()
		}
		catch (let error) {
			throw error
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: - Tests

	func testEmpty() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestEmpty")

			// TEST: program contains no statements or declarations
			XCTAssertNil(tree.toJKRTreeStatements())
			XCTAssertNil(tree.toJKRTreeDeclarations())
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testIDs() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestIDs")

			let ids = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.flatMap { $0.variableDeclaration()?.ID()?.toJKRTreeID() }

			let expectedIDs: [JKRTreeID] = ["bla", "fooBar", "baz", "fooBar",
			                                "bla"]

			// TEST: All elements were converted successfully
			XCTAssertEqual(ids, expectedIDs)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testTypes() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestTypes")

			let types = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.flatMap { $0.variableDeclaration()?.TYPE()?.toJKRTreeType() }

			let expectedTypes: [JKRTreeType] = ["Int", "Float", "Blah", "Int",
			                                     "Void"]

			// TEST: All elements were converted successfully
			XCTAssertEqual(types, expectedTypes)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testStatements() {
		do {
			// WITH:
			let tree = try getProgram(inFile:  "TestStatements")

			guard let statements = tree.toJKRTreeStatements() else {
				XCTFail("Failed to get statements from statements file.")
				return
			}

			let expectedStatements: [JKRTreeStatement] = [
				.assignment(.declaration("Int", "x", 0)),
				.assignment(.declaration("Int", "y", 0)),
				.functionCall(JKRTreeFunctionCall(id: "f")),
				.returnStm(1)
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(statements, expectedStatements)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testDeclarations() {
		do {
			// WITH:
			let tree = try getProgram(inFile:  "TestDeclarations")

			guard let declarations = tree.toJKRTreeDeclarations() else {
				XCTFail("Failed to get declarations from declarations file.")
				return
			}

			let expectedDeclarations: [JKRTreeDeclaration] = [
				.functionDeclaration(
					JKRTreeFunctionDeclaration(
						type: "Int", id: "func1",
						parameters: [],
						block: [.returnStm(0)]
					)
				),
				.functionDeclaration(
					JKRTreeFunctionDeclaration(
						type: "Int", id: "func2",
						parameters: [JKRTreeParameterDeclaration(type: "Float",
						                              id: "bla")],
						block: [
							JKRTreeStatement.assignment(.declaration(
								"String", "baz", .operation(5, "+", 6))),
							JKRTreeStatement.returnStm(0)]
					)
				)
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(declarations, expectedDeclarations)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testOperator() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestOperators")

			let operators = tree.filter(type:
				JokrParser.ExpressionContext.self)
				.flatMap { $0.OPERATOR()?.toJKRTreeOperator() }

			let expectedOperators: [JKRTreeOperator] = ["+", "-", "+"]

			// TEST: All elements were converted successfully
			XCTAssertEqual(operators, expectedOperators)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testExpressions() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestExpressions")

			let expressions = tree.filter(type:
				JokrParser.ExpressionContext.self)
				// Filter only root expressions, subexpressions get tested too
				.filter { !($0.parent is JokrParser.ExpressionContext) }
				.map { $0.toJKRTreeExpression() }

			let expectedExpressions: [JKRTreeExpression] = [
				0,
				.parenthesized(1),
				.operation(2, "+", 3),
				JKRTreeExpression.lvalue("foo"),
				.operation(4, "+",
				           .parenthesized(
							.operation(.parenthesized(5),
							           "+", "foo")))
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(expressions, expectedExpressions)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testParameters() {
//		do {
//			let tree = try getProgram(inFile: "TestParameters")
//
//			let parameterLists = tree.filter(type:
//				JokrParser.ParameterListContext.self)
//				// Filter only root parameter lists, sublists get tested too
//				.filter {
//					!($0.parent is JokrParser.ParameterDeclarationListContext)
//				}.map { $0.toJKRTreeExpressions() }
//
//			let expectedParameterLists: [[JKRTreeExpression]] = [
//				[],
//				[JKRTreeParameterDeclaration(type: "Float", id: "bla")],
//				[JKRTreeParameterDeclaration(type: "Int", id: "bla"),
//				 JKRTreeParameterDeclaration(type: "Float", id: "foo")],
//				[JKRTreeParameterDeclaration(type: "Int", id: "bla"),
//				 JKRTreeParameterDeclaration(type: "Float", id: "foo"),
//				 JKRTreeParameterDeclaration(type: "Double", id: "hue")]
//			]
//
//			// TEST: All elements were converted successfully
//			// (multi-dimensional array equality has to be unrolled like this)
//			for (parameterList, expectedParameterList)
//				in zip(parameterLists, expectedParameterLists)
//			{
//				XCTAssertEqual(parameterList, expectedParameterList)
//			}
//			XCTAssertEqual(parameterLists.count, expectedParameterLists.count)
//		}
//		catch (let error) {
//			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
//		}
	}

	func testAssignments() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestAssignments")

			let assignments = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.map { $0.toJKRTreeAssignment() }

			let expectedAssignments: [JKRTreeAssignment] = [
				.declaration("Int", "bla", 2),
				.declaration("Float", "fooBar", 3),
				.declaration("Blah", "baz", "fooBar"),
				.assignment("fooBar", "bla"),
				.assignment("bla", 300)
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(assignments, expectedAssignments)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testFunctionCall() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestFunctionCalls")

			let functionCalls = tree.filter(type:
				JokrParser.FunctionCallContext.self)
				.map { $0.toJKRTreeFunctionCall() }

			let expectedFunctionCalls: [JKRTreeFunctionCall] = [
				JKRTreeFunctionCall(id: "print"),
				JKRTreeFunctionCall(id: "f"),
				JKRTreeFunctionCall(id: "someFunctionName")
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(functionCalls, expectedFunctionCalls)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testReturns() {
		do {
			// WITH:
			let tree = try getProgram(inFile:  "TestReturns")

			let returns = tree.filter(type:
				JokrParser.ReturnStatementContext.self)
				.map { $0.toJKRTreeReturn() }

			let expectedReturns: [JKRTreeReturn] = [
				0,
				JKRTreeReturn(.operation(5, "+", 6)),
				JKRTreeReturn(.parenthesized(9)),
				"bla"
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(returns, expectedReturns)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testParameterDeclarations() {
		do {
			let tree = try getProgram(inFile: "TestParameterDeclarations")

			let parameterLists = tree.filter(type:
				JokrParser.ParameterDeclarationListContext.self)
				// Filter only root parameter lists, sublists get tested too
				.filter {
					!($0.parent is JokrParser.ParameterDeclarationListContext)
				}.map { $0.toJKRTreeParameterDeclarations() }

			let expectedParameterLists: [[JKRTreeParameterDeclaration]] = [
				[],
				[JKRTreeParameterDeclaration(type: "Float", id: "bla")],
				[JKRTreeParameterDeclaration(type: "Int", id: "bla"),
				 JKRTreeParameterDeclaration(type: "Float", id: "foo")],
				[JKRTreeParameterDeclaration(type: "Int", id: "bla"),
				 JKRTreeParameterDeclaration(type: "Float", id: "foo"),
				 JKRTreeParameterDeclaration(type: "Double", id: "hue")]
			]

			// TEST: All elements were converted successfully
			// (multi-dimensional array equality has to be unrolled like this)
			for (parameterList, expectedParameterList)
				in zip(parameterLists, expectedParameterLists)
			{
				XCTAssertEqual(parameterList, expectedParameterList)
			}
			XCTAssertEqual(parameterLists.count, expectedParameterLists.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testFunctionDeclarations() {
		do {
			// WITH:
			let tree = try getProgram(inFile: "TestFunctionDeclarations")

			let declarations = tree.filter(type:
				JokrParser.FunctionDeclarationContext.self)
				.map { $0.toJKRTreeFunctionDeclaration() }

			let expectedDeclarations: [JKRTreeFunctionDeclaration] = [
				JKRTreeFunctionDeclaration(
					type: "Int", id: "func1",
					parameters: [],
					block: [.returnStm(0)]),
				JKRTreeFunctionDeclaration(
					type: "Int", id: "func2",
					parameters: [JKRTreeParameterDeclaration(type: "Float", id: "bla")],
					block: [
						.assignment(.declaration(
							"String", "baz",
							.operation(5, "+", 6))),
						.returnStm(0)]),
				JKRTreeFunctionDeclaration(
					type: "Void", id: "func4",
					parameters: [JKRTreeParameterDeclaration(type: "Int", id: "bla"),
					             JKRTreeParameterDeclaration(type: "Float", id: "foo"),
					             JKRTreeParameterDeclaration(type: "Double", id: "hue")],
					block: [.returnStm(0)])
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(declarations, expectedDeclarations)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}
}
