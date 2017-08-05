import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr To Jokr Tests/"

class AntlrToJokrTests: XCTestCase {
	func testIDs() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestIDs")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let ids = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.flatMap { $0.variableDeclaration()?.ID()?.toJKRTreeID() }

			let expectedIDs: [JKRTreeID] = ["bla", "fooBar", "baz", "fooBar",
			                                "bla"]

			XCTAssertEqual(ids, expectedIDs)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testTypes() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestTypes")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let types = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.flatMap { $0.variableDeclaration()?.TYPE()?.toJKRTreeType() }

			let expectedTypess: [JKRTreeType] = ["Int", "Float", "Blah", "Int",
			                                     "Void"]

			XCTAssertEqual(types, expectedTypess)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testExpressions() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestExpressions")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let expressions = tree.filter(type:
				JokrParser.ExpressionContext.self)
				// Filter only root expressions, subexpressions get tested too
				.filter { !($0.parent is JokrParser.ExpressionContext) }
				.map { $0.toJKRTreeExpression() }

			let expectedExpressions: [JKRTreeExpression] = [
				.int("0"),
				.parenthesized(.int("1")),
				.operation(.int("2"), "+", .int("3")),
				JKRTreeExpression.lvalue("foo"),
				.operation(.int("4"), "+",
				           .parenthesized(
							.operation(.parenthesized(.int("5")),
							           "+", .lvalue("foo"))))
			]

			XCTAssertEqual(expressions, expectedExpressions)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testAssignments() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestAssignments")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let assignments = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.map { $0.toJKRTreeAssignment() }

			let expectedAssignments: [JKRTreeAssignment] = [
				.declaration("Int", "bla", .int("2")),
				.declaration("Float", "fooBar", .int("3")),
				.declaration("Blah", "baz", .lvalue("fooBar")),
				.assignment("fooBar", .lvalue("bla")),
				.assignment("bla", .int("300"))
			]

			XCTAssertEqual(assignments, expectedAssignments)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testParameters() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestParameters")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let parameters = tree.filter(type:
				JokrParser.ParameterDeclarationListContext.self)
				// Filter only root parameter lists, sublists get tested too
				.filter {
					!($0.parent is JokrParser.ParameterDeclarationListContext)
				}.map { $0.toJKRTreeParameters() }

			let expectedParameters: [[JKRTreeParameter]] = [
				[],
				[JKRTreeParameter(type: "Float", id: "bla")],
				[JKRTreeParameter(type: "Int", id: "bla"),
				 JKRTreeParameter(type: "Float", id: "foo")],
				[JKRTreeParameter(type: "Int", id: "bla"),
				 JKRTreeParameter(type: "Float", id: "foo"),
				 JKRTreeParameter(type: "Double", id: "hue")],
			]

			for (parameter, expectedParameter)
				in zip(parameters, expectedParameters)
			{
				XCTAssertEqual(parameter, expectedParameter)
			}
			XCTAssertEqual(parameters.count, expectedParameters.count)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testFunctionDeclarations() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestFunctionDeclarations")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let declarations = tree.filter(type:
				JokrParser.FunctionDeclarationContext.self)
				.map { $0.toJKRTreeFunctionDeclaration() }

			let expectedDeclarations: [JKRTreeFunctionDeclaration] = [
				JKRTreeFunctionDeclaration(
					type: "Int", id: "func1",
					parameters: [],
					block: [.returnStm(.int("0"))]),
				JKRTreeFunctionDeclaration(
					type: "Int", id: "func2",
					parameters: [JKRTreeParameter(type: "Float", id: "bla")],
					block: [
						.assignment(.declaration(
							"String", "baz",
							.operation(.int("5"), "+", .int("6")))),
						.returnStm(.int("0"))]),
				JKRTreeFunctionDeclaration(
					type: "Void", id: "func4",
					parameters: [JKRTreeParameter(type: "Int", id: "bla"),
					             JKRTreeParameter(type: "Float", id: "foo"),
					             JKRTreeParameter(type: "Double", id: "hue")],
					block: [.returnStm(.int("0"))])
			]

			XCTAssertEqual(declarations, expectedDeclarations)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testReturns() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestReturns")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let returns = tree.filter(type:
				JokrParser.ReturnStatementContext.self)
				.map { $0.getJKRTreeExpression() }

			let expectedReturns: [JKRTreeExpression] = [
				.int("0"),
				.operation(.int("5"), "+", .int("6")),
				.parenthesized(.int("9"))
			]

			XCTAssertEqual(returns, expectedReturns)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testStatements() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestStatements")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let statements = tree.filter(type:
				JokrParser.StatementContext.self)
				.map { $0.toJKRTreeStatement() }

			let expectedStatements: [JKRTreeStatement] = [
				.functionDeclaration(
					JKRTreeFunctionDeclaration(
						type: "Int", id: "foo",
						parameters: [],
						block: [
							.assignment(.declaration("Int", "x", .int("0"))),
							.returnStm(.int("0"))])),
				.assignment(.declaration("Int", "x", .int("0"))),
				.returnStm(.int("0")),

				.assignment(.declaration("Int", "y", .int("0"))),
				.returnStm(.int("1"))
			]

			XCTAssertEqual(statements, expectedStatements)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testProgram() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestStatements")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let statements = tree.toJKRTreeStatements()

			let expectedStatements: [JKRTreeStatement] = [
				.functionDeclaration(
					JKRTreeFunctionDeclaration(
						type: "Int", id: "foo",
						parameters: [],
						block: [
							.assignment(.declaration("Int", "x", .int("0"))),
							.returnStm(.int("0"))])),
				.assignment(.declaration("Int", "y", .int("0"))),
				.returnStm(.int("1"))
			]

			XCTAssertEqual(statements, expectedStatements)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testEmpty() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestEmpty")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let statements = tree.toJKRTreeStatements()

			XCTAssertEqual(statements, [])
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}
}
