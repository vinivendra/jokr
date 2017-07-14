import Antlr4
import XCTest

// TODO: Remove !

private let testFilesPath = CommandLine.arguments[1] +
	"/AntlrTests/AntlrUnitTests/ParserTests/"

class ParserTests: XCTestCase {
	typealias TokenTest =
		(startLine: Int,
		startChar: Int,
		text: String)

	func testStatementLists() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestStatementLists")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let statementLists = tree.filter {
				$0 is JokrParser.StatementListContext
			}

			let statements = tree.filter {
				$0 is JokrParser.StatementContext
			}

			let expectedStatementLists: [TokenTest] = [(1, 0, "x=0\nx=1"),
			                                           (1, 0, "x=0")]

			let expectedStatements: [TokenTest] = [(1, 0, "x=0"), (2, 0, "x=1")]

			XCTAssertEqual(statementLists.count, expectedStatementLists.count)
			XCTAssertEqual(statements.count, expectedStatementLists.count)

			for (expected, actual) in
				zip(expectedStatementLists, statementLists)
			{
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			for (expected, actual) in zip(expectedStatements, statements) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		} catch (let error) {
			XCTFail("Lexer or Parser failed to get tokens.\nError: \(error)")
		}
	}

	func testStatementListsWithNewline() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestStatementListsWithNewline")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let statementLists = tree.filter {
				$0 is JokrParser.StatementListContext
				}

			let statements = tree.filter {
				$0 is JokrParser.StatementContext
				}

			let expectedStatementLists: [TokenTest] = [
				(1, 0, "x=0\nx=1\nx=2"), (1, 0, "x=0\nx=1"),
				(1, 0, "x=0")]

			let expectedStatements: [TokenTest] =
				[(1, 0, "x=0"), (2, 0, "x=1"), (3, 0, "x=2")]

			XCTAssertEqual(statementLists.count, expectedStatementLists.count)
			XCTAssertEqual(statements.count, expectedStatementLists.count)

			for (expected, actual) in
				zip(expectedStatementLists, statementLists)
			{
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			for (expected, actual) in zip(expectedStatements, statements) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			statementLists.forEach {
				print($0.getText())
				print($0.getStart()!.getLine())
				print($0.getStart()!.getCharPositionInLine())
				print($0.getStop()!.getLine())
				print($0.getStop()!.getCharPositionInLine())
			}

		} catch (let error) {
			XCTFail("Lexer or Parser failed to get tokens.\nError: \(error)")
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

			let assignments = tree.filter {
				$0 is JokrParser.AssignmentContext
				}

			let expectedAssignments: [TokenTest] = [
				(1, 0, "Intbla=2"), (2, 0, "FloatfooBar=3"),
				(3, 0, "Blahbaz=fooBar"), (4, 0, "fooBar=bla"),
				(5, 0, "bla=300")]

			XCTAssertEqual(assignments.count, expectedAssignments.count)

			for (expected, actual) in zip(expectedAssignments, assignments) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		} catch (let error) {
			XCTFail("Lexer or Parser failed to get tokens.\nError: \(error)")
		}
	}

	func testVariableDeclarations() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestVariableDeclarations")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let declarations = tree.filter {
				$0 is JokrParser.VariableDeclarationContext
			}

			let expectedDeclarations: [TokenTest] = [(1, 0, "Intbla"),
			                                         (2, 0, "Floatfoo")]

			XCTAssertEqual(declarations.count, expectedDeclarations.count)

			for (expected, actual) in zip(expectedDeclarations, declarations) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		} catch (let error) {
			XCTFail("Lexer or Parser failed to get tokens.\nError: \(error)")
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

			let expressions = tree.filter {
				$0 is JokrParser.ExpressionContext
			}

			let expectedExpressions: [TokenTest] = [
				(1, 10, "0"),
				(2, 10, "(1)"), (2, 11, "1"),
				(3, 10, "2+3"), (3, 10, "2"), (3, 14, "3"),
				(4, 10, "foo"),
				(5, 10, "4+((5)+foo)"), (5, 10, "4"), (5, 14, "((5)+foo)"),
				(5, 15, "(5)+foo"), (5, 15, "(5)"), (5, 16, "5"),
				(5, 21, "foo")]

			XCTAssertEqual(expressions.count, expectedExpressions.count)

			for (expected, actual) in zip(expectedExpressions, expressions) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		} catch (let error) {
			XCTFail("Lexer or Parser failed to get tokens.\nError: \(error)")
		}
	}
}
