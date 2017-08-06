// Files dealing with Antlr are allowed to force-unwrap
// swiftlint:disable force_unwrapping

import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Parser Tests/"

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

			let statementLists = tree.filter(type:
				JokrParser.StatementListContext.self)

			let statements = tree.filter(type: JokrParser.StatementContext.self)

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

		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
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

			let statementLists = tree.filter(type:
				JokrParser.StatementListContext.self)

			let statements = tree.filter(type: JokrParser.StatementContext.self)

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

		}
		catch (let error) {
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

		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
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

			let declarations = tree.filter(type:
				JokrParser.VariableDeclarationContext.self)

			let expectedDeclarations: [TokenTest] = [(1, 0, "Intbla"),
			                                         (2, 0, "Floatfoo")]

			XCTAssertEqual(declarations.count, expectedDeclarations.count)

			for (expected, actual) in zip(expectedDeclarations, declarations) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		}
		catch (let error) {
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

		}
		catch (let error) {
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

			let expectedDeclarations: [TokenTest] = [
				(1, 0, "Intfive(){\nIntx=4\nx=5\nreturn5\n}"),
				(7, 0,
				 "Intnumber(Intnumber){\nresult=number\nreturnresult\n}"),
				(12, 0, "Intsum(Inta,Intb,Intc){\nreturna+b+c\n}")]

			XCTAssertEqual(declarations.count, expectedDeclarations.count)

			for (expected, actual) in zip(expectedDeclarations, declarations) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testParameterDeclaration() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestFunctionDeclarations")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let parameterLists = tree.filter(type:
				JokrParser.ParameterDeclarationListContext.self)

			let parameters = tree.filter(type:
				JokrParser.ParameterDeclarationContext.self)

			let expectedParameterLists: [TokenTest] = [
				(1, 9, ""), (7, 11, "Intnumber"), (12, 8, "Inta,Intb,Intc"),
				(12, 8, "Inta,Intb"), (12, 8, "Inta")]

			let expectedParameters: [TokenTest] = [
				(7, 11, "Intnumber"), (12, 8, "Inta"), (12, 15, "Intb"),
				(12, 22, "Intc")]

			XCTAssertEqual(parameterLists.count, expectedParameterLists.count)
			XCTAssertEqual(parameters.count, expectedParameters.count)

			for (expected, actual) in
				zip(expectedParameterLists, parameterLists)
			{
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			for (expected, actual) in zip(expectedParameters, parameters) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	//	for context in parameterLists {
	//		print(context.getStart()!.getLine())
	//		print(context.getStart()!.getCharPositionInLine())
	//		print(context.getText())
	//	}

}
