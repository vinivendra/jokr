// Files dealing with Antlr are allowed to force-unwrap
// swiftlint:disable force_unwrapping

import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr Parser Tests/"

class AntlrParserTests: XCTestCase {
	typealias TokenTest =
		(startLine: Int,
		startChar: Int,
		text: String)

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

	func testStatementLists() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestStatementLists")

            let statementLists = tree.filter(type:
				JokrParser.StatementListContext.self)

            let statements = tree.filter(type: JokrParser.StatementContext.self)

			let expectedStatementLists: [TokenTest] = [
				(1, 0, "x=0\nx=1\nf()"),
				(1, 0, "x=0\nx=1"),
				(1, 0, "x=0")]

			let expectedStatements: [TokenTest] = [
				(1, 0, "x=0"),
				(2, 0, "x=1"),
				(3, 0, "f()")]

			// TEST: Parser found all expected elements
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

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(statementLists.count, expectedStatementLists.count)
			XCTAssertEqual(statements.count, expectedStatementLists.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testStatementListsWithNewline() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestStatementListsWithNewline")

            let statementLists = tree.filter(type:
				JokrParser.StatementListContext.self)

            let statements = tree.filter(type: JokrParser.StatementContext.self)

			let expectedStatementLists: [TokenTest] = [
				(1, 0, "x=0\nx=1\nx=2\nf()"), (1, 0, "x=0\nx=1\nx=2"),
				(1, 0, "x=0\nx=1"), (1, 0, "x=0")]

			let expectedStatements: [TokenTest] =
				[(1, 0, "x=0"), (2, 0, "x=1"), (3, 0, "x=2"), (4, 0, "f()")]

			// TEST: Parser found all expected elements
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

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(statementLists.count, expectedStatementLists.count)
			XCTAssertEqual(statements.count, expectedStatementLists.count)
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

			let expectedExpressions: [TokenTest] = [
				(1, 10, "0"),
				(2, 10, "(1)"), (2, 11, "1"),
				(3, 10, "2+3"), (3, 10, "2"), (3, 14, "3"),
				(4, 10, "foo"),
				(5, 10, "4+((5)+foo)"), (5, 10, "4"), (5, 14, "((5)+foo)"),
				(5, 15, "(5)+foo"), (5, 15, "(5)"), (5, 16, "5"),
				(5, 21, "foo")]

			// TEST: Parser found all expected elements
			for (expected, actual) in zip(expectedExpressions, expressions) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(expressions.count, expectedExpressions.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testParameters() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestParameters")

            let parameterLists = tree.filter(type:
				JokrParser.ParameterListContext.self)

            let parameters = tree.filter(type:
				JokrParser.ParameterContext.self)

			let expectedParameterLists: [TokenTest] = [
				(1, 4, ""),
				(2, 4, "bar"),
				(3, 4, "(1+2)"),
				(4, 4, "(hue)"),
				(5, 4, "foo,(baz),blah"),
				(5, 4, "foo,(baz)"),
				(5, 4, "foo")
			]

			let expectedParameters: [TokenTest] = [
				(2, 4, "bar"),
				(3, 4, "(1+2)"),
				(4, 4, "(hue)"),
				(5, 4, "foo"),
				(5, 9, "(baz)"),
				(5, 16, "blah")
			]

			// TEST: Parser founAd all expected elements
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

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(parameterLists.count, expectedParameterLists.count)
			XCTAssertEqual(parameters.count, expectedParameters.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testAssignments() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestAssignments")

            let assignments = tree.filter(type:
				JokrParser.AssignmentContext.self)

			let expectedAssignments: [TokenTest] = [
				(1, 0, "Intbla=2"), (2, 0, "FloatfooBar=3"),
				(3, 0, "Blahbaz=fooBar"), (4, 0, "fooBar=bla"),
				(5, 0, "bla=300")]

			// TEST: Parser found all expected elements
			for (expected, actual) in zip(expectedAssignments, assignments) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(assignments.count, expectedAssignments.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testVariableDeclarations() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestVariableDeclarations")

            let declarations = tree.filter(type:
				JokrParser.VariableDeclarationContext.self)

			let expectedDeclarations: [TokenTest] = [(1, 0, "Intbla"),
			                                         (2, 0, "Floatfoo")]

			// TEST: Parser found all expected elements
			for (expected, actual) in zip(expectedDeclarations, declarations) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(declarations.count, expectedDeclarations.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testFunctionCalls() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestFunctionCalls")

            let functionCalls = tree.filter(type:
				JokrParser.FunctionCallContext.self)

			let expectedFunctionCalls: [TokenTest] = [
				(1, 0, "print()"),
				(2, 0, "f()"),
				(3, 0, "someFunctionName(1)"),
				(4, 0, "someFunctionName(1,2)")
			]

			// TEST: Parser found all expected elements
			for (expected, actual) in zip(expectedFunctionCalls, functionCalls)
			{
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(functionCalls.count, expectedFunctionCalls.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testParameterDeclaration() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestFunctionDeclarations")

            let parameterLists = tree.filter(type:
				JokrParser.ParameterDeclarationListContext.self)

            let parameters = tree.filter(type:
				JokrParser.ParameterDeclarationContext.self)

			let expectedParameterLists: [TokenTest] = [
				(2, 10, ""), (8, 12, "Intnumber"), (13, 9, "Inta,Intb,Intc"),
				(13, 9, "Inta,Intb"), (13, 9, "Inta")]

			let expectedParameters: [TokenTest] = [
				(8, 12, "Intnumber"), (13, 9, "Inta"), (13, 16, "Intb"),
				(13, 23, "Intc")]

			// TEST: Parser found all expected elements
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

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(parameterLists.count, expectedParameterLists.count)
			XCTAssertEqual(parameters.count, expectedParameters.count)
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

			// TEST: Parser found all expected elements
			let expectedDeclarations: [TokenTest] = [
				(2, 1, "Intfive(){\n\t\tIntx=4\n\t\tx=5\n\t\treturn5\n\t}"),
				(8, 1,
				 "Intnumber(Intnumber){\n\t\tresult=number\n\t\treturnresult\n\t}"),
				(13, 1, "Intsum(Inta,Intb,Intc){\n\t\treturna+b+c\n\t}")]

			for (expected, actual) in zip(expectedDeclarations, declarations) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(declarations.count, expectedDeclarations.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	func testClassDeclarations() {
		do {
			// WITH:
            let tree = try getProgram(inFile: "TestClassDeclarations")

            let declarations = tree.filter(type:
				JokrParser.ClassDeclarationContext.self)

			// TEST: Parser found all expected elements
			let expectedDeclarations: [TokenTest] =
				[(1, 0, "classPerson{\n\n}")]

			for (expected, actual) in zip(expectedDeclarations, declarations) {
				XCTAssertEqual(actual.getStart()!.getLine(), expected.startLine)
				XCTAssertEqual(actual.getStart()!.getCharPositionInLine(),
				               expected.startChar)
				XCTAssertEqual(actual.getText(), expected.text)
			}

			// TEST: Parser didn't find any unexpected elements of this type
			XCTAssertEqual(declarations.count, expectedDeclarations.count)
		}
		catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}

	// Code snippet to print all found contexts, helps when creating new tests.
	//
	//	for context in contexts {
	//		print(context.getStart()!.getLine())
	//		print(context.getStart()!.getCharPositionInLine())
	//		print(context.getText())
	//	}
}
