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

}
