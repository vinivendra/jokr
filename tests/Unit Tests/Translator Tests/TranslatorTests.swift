import XCTest

class TranslatorTests: XCTestCase {
	let translator = JKRTranslator(language: JKRLanguageDataSourceMockup())

	func testFileStart() {
		XCTAssertEqual(translator.stringForFileStart(),
		               "File start\n")
	}

	func testExpressions() {
		var statement: JKRTreeStatement =
			.assignment(.assignment("x", .int("0")))
		XCTAssertEqual(translator.translateStatement(statement), "x = 0;\n")

		statement = .assignment(.assignment("x", .parenthesized(.int("0"))))
		XCTAssertEqual(translator.translateStatement(statement), "x = (0);\n")

		statement = .assignment(.assignment("x", .lvalue("bla")))
		XCTAssertEqual(translator.translateStatement(statement), "x = bla;\n")

		statement = .assignment(.assignment(
			"x", .operation(.int("0"), "+", .int("1"))))
		XCTAssertEqual(translator.translateStatement(statement), "x = 0 + 1;\n")

		statement = .assignment(.assignment(
			"x", .parenthesized(.operation(.int("0"), "+", .int("1")))))
		XCTAssertEqual(translator.translateStatement(statement),
		               "x = (0 + 1);\n")
	}

	func testAssignments() {
		var statement: JKRTreeStatement =
			.assignment(.declaration("int", "x", .int("0")))
		XCTAssertEqual(translator.translateStatement(statement), "int x = 0;\n")

		statement = .assignment(.assignment("x", .int("0")))
		XCTAssertEqual(translator.translateStatement(statement), "x = 0;\n")
	}

	func testReturns() {
		var statement: JKRTreeStatement = .returnStm(.int("0"))
		XCTAssertEqual(translator.translateStatement(statement), "return 0;\n")

		statement = .returnStm(.parenthesized(.int("0")))
		XCTAssertEqual(translator.translateStatement(statement),
		               "return (0);\n")
	}

	func testFunctionDeclarations() {
		var statement: JKRTreeStatement = .functionDeclaration(
			JKRTreeFunctionDeclaration(
				type: "void", id: "main", parameters: [], block: []))
		XCTAssertEqual(translator.translateStatement(statement),
		               "void main([])")

		statement = .functionDeclaration(JKRTreeFunctionDeclaration(
			type: "String", id: "foo", parameters: [], block: []))
		XCTAssertEqual(translator.translateStatement(statement),
		               "String foo([])")

		statement = .functionDeclaration(JKRTreeFunctionDeclaration(
			type: "String", id: "foo",
			parameters: [JKRTreeParameter(type: "int", id: "five")], block: []))
		XCTAssertEqual(translator.translateStatement(statement),
		               "String foo([jokrUnitTests.JKRTreeParameter(type: jokrUnitTests.JKRTreeType(text: \"int\"), id: jokrUnitTests.JKRTreeID(text: \"five\"))])")
		// swiftlint:disable:previous line_length

		statement = .functionDeclaration(JKRTreeFunctionDeclaration(
			type: "String", id: "foo",
			parameters: [JKRTreeParameter(type: "int", id: "five"),
			             JKRTreeParameter(type: "float", id: "four")],
			block: []))
		XCTAssertEqual(translator.translateStatement(statement),
		               "String foo([jokrUnitTests.JKRTreeParameter(type: jokrUnitTests.JKRTreeType(text: \"int\"), id: jokrUnitTests.JKRTreeID(text: \"five\")), jokrUnitTests.JKRTreeParameter(type: jokrUnitTests.JKRTreeType(text: \"float\"), id: jokrUnitTests.JKRTreeID(text: \"four\"))])")
		// swiftlint:disable:previous line_length

		statement = .functionDeclaration(JKRTreeFunctionDeclaration(
			type: "String", id: "foo", parameters: [],
			block: [.returnStm(.int("0"))]))
		XCTAssertEqual(translator.translateStatement(statement),
		               "String foo([])")
	}
}
