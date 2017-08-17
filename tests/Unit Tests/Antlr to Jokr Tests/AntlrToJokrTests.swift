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

			let expectedTypess: [JKRTreeType] = ["Int", "Float", "Blah", "Int",
			                                     "Void"]

			// TEST: All elements were converted successfully
			XCTAssertEqual(types, expectedTypess)
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

	func testAssignments() {
		do {
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

	func testParameters() {
		do {
			let tree = try getProgram(inFile: "TestParameters")

			let parameterLists = tree.filter(type:
				JokrParser.ParameterDeclarationListContext.self)
				// Filter only root parameter lists, sublists get tested too
				.filter {
					!($0.parent is JokrParser.ParameterDeclarationListContext)
				}.map { $0.toJKRTreeParameters() }

			let expectedParameterLists: [[JKRTreeParameter]] = [
				[],
				[JKRTreeParameter(type: "Float", id: "bla")],
				[JKRTreeParameter(type: "Int", id: "bla"),
				 JKRTreeParameter(type: "Float", id: "foo")],
				[JKRTreeParameter(type: "Int", id: "bla"),
				 JKRTreeParameter(type: "Float", id: "foo"),
				 JKRTreeParameter(type: "Double", id: "hue")]
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

//	func testFunctionDeclarations() {
//		let contents = try! String(contentsOfFile:
//			testFilesPath + "TestFunctionDeclarations")
//
//		let inputStream = ANTLRInputStream(contents)
//		let lexer = JokrLexer(inputStream)
//		let tokens = CommonTokenStream(lexer)
//
//		do {
//			let parser = try JokrParser(tokens)
//			parser.setBuildParseTree(true)
//			let tree = try parser.program()
//
//			let declarations = tree.filter(type:
//				JokrParser.FunctionDeclarationContext.self)
//				.map { $0.toJKRTreeFunctionDeclaration() }
//
//			let expectedDeclarations: [JKRTreeFunctionDeclaration] = [
//				JKRTreeFunctionDeclaration(
//					type: "Int", id: "func1",
//					parameters: [],
//					block: [.returnStm(0)]),
//				JKRTreeFunctionDeclaration(
//					type: "Int", id: "func2",
//					parameters: [JKRTreeParameter(type: "Float", id: "bla")],
//					block: [
//						.assignment(.declaration(
//							"String", "baz",
//							.operation(5, "+", 6))),
//						.returnStm(0)]),
//				JKRTreeFunctionDeclaration(
//					type: "Void", id: "func4",
//					parameters: [JKRTreeParameter(type: "Int", id: "bla"),
//					             JKRTreeParameter(type: "Float", id: "foo"),
//					             JKRTreeParameter(type: "Double", id: "hue")],
//					block: [.returnStm(0)])
//			]
//
//			XCTAssertEqual(declarations, expectedDeclarations)
//		}
//		catch (let error) {
//			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
//		}
//	}

	func testReturns() {
		do {
			// WITH:
			let tree = try getProgram(inFile:  "TestReturns")

			let returns = tree.filter(type:
				JokrParser.ReturnStatementContext.self)
				.map { $0.getJKRTreeReturn() }

			let expectedReturns: [JKRTreeReturn] = [
				JKRTreeReturn(0),
				JKRTreeReturn(.operation(5, "+", 6)),
				JKRTreeReturn(.parenthesized(9))
			]

			// TEST: All elements were converted successfully
			XCTAssertEqual(returns, expectedReturns)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

//	func testStatements() {
//		let contents = try! String(contentsOfFile:
//			testFilesPath + "TestStatements")
//
//		let inputStream = ANTLRInputStream(contents)
//		let lexer = JokrLexer(inputStream)
//		let tokens = CommonTokenStream(lexer)
//
//		do {
//			let parser = try JokrParser(tokens)
//			parser.setBuildParseTree(true)
//			let tree = try parser.program()
//
//			let statements = tree.filter(type:
//				JokrParser.StatementContext.self)
//				.map { $0.toJKRTreeStatement() }
//
//			let expectedStatements: [JKRTreeStatement] = [
//				.functionDeclaration(
//					JKRTreeFunctionDeclaration(
//						type: "Int", id: "foo",
//						parameters: [],
//						block: [
//							.assignment(.declaration("Int", "x", 0)),
//							.returnStm(0)])),
//				.assignment(.declaration("Int", "x", 0)),
//				.returnStm(0),
//
//				.assignment(.declaration("Int", "y", 0)),
//				.returnStm(1)
//			]
//
//			XCTAssertEqual(statements, expectedStatements)
//		}
//		catch (let error) {
//			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
//		}
//	}
//
//	func testProgram() {
//		let contents = try! String(contentsOfFile:
//			testFilesPath + "TestStatements")
//
//		let inputStream = ANTLRInputStream(contents)
//		let lexer = JokrLexer(inputStream)
//		let tokens = CommonTokenStream(lexer)
//
//		do {
//			let parser = try JokrParser(tokens)
//			parser.setBuildParseTree(true)
//			let tree = try parser.program()
//
//			let statements = tree.toJKRTreeStatements()
//
//			let expectedStatements: [JKRTreeStatement] = [
//				.functionDeclaration(
//					JKRTreeFunctionDeclaration(
//						type: "Int", id: "foo",
//						parameters: [],
//						block: [
//							.assignment(.declaration("Int", "x", 0)),
//							.returnStm(0)])),
//				.assignment(.declaration("Int", "y", 0)),
//				.returnStm(1)
//			]
//
//			XCTAssertEqual(statements, expectedStatements)
//		}
//		catch (let error) {
//			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
//		}
//	}

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
}
