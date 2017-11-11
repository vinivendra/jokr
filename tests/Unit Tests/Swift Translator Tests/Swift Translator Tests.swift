import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Swift Translator Tests/"

private let errorMessage =
"""
Lexer, Parser or Translator failed during test.
Error:
"""

////////////////////////////////////////////////////////////////////////////////
class SwiftTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(_ tree: JKRTree) throws -> [String: String] {
		let writer = JKRStringWriter()
		let translator = JKRSwiftTranslator(writingWith: writer)
		try translator.translate(tree: tree)
		writer.prettyPrint()
		return writer.files
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: - Tests

	func testAssignments() {
		do {
			// WITH:
			let testName = "TestAssignments"

			let tree = JKRTree.statements([
				.assignment(.declaration("Int", "x", 2)),
				.assignment(.declaration("Int", "y",
				                         .operation("x", "+", "x"))),
				.assignment(.declaration("Float", "z",
				                         .operation("y", "-", "x"))),
				.assignment(.assignment(
					"y",
					.operation(.parenthesized(
						.operation("z", "+", "x")), "-", "y")))
				])

			let files = try translate(tree)

			// TEST: Files get created with correct contents
			for (filename, contents) in files {
				let expectedContents = try String(
					contentsOfFile: "\(testFilesPath)\(testName)/\(filename)")
				XCTAssertEqual(contents, expectedContents,
				               "Translation failed in file \(filename)")
			}

			// TEST: No other files get created
			XCTAssertEqual(files.count, 1)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testFunctionCall() {
		do {
			// WITH:
			let testName = "TestFunctionCalls"

			let tree = JKRTree.statements([
				.functionCall(JKRTreeFunctionCall(id: "print")),
				.functionCall(JKRTreeFunctionCall(id: "print",
				                                  parameters: [1])),
				.functionCall(JKRTreeFunctionCall(id: "print",
				                                  parameters: [1, 2]))
				])

			let files = try translate(tree)

			// TEST: Files get created with correct contents
			for (filename, contents) in files {
				let expectedContents = try String(
					contentsOfFile: "\(testFilesPath)\(testName)/\(filename)")
				XCTAssertEqual(contents, expectedContents,
				               "Translation failed in file \(filename)")
			}

			// TEST: No other files get created
			XCTAssertEqual(files.count, 1)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testClassDeclarations() {
		do {
			// WITH:
			let testName = "TestClassDeclarations"

			let tree = JKRTree.classDeclarations([
				JKRTreeClassDeclaration(type: "Person"),
				JKRTreeClassDeclaration(
					type: "Animal",
					methods: [JKRTreeFunctionDeclaration(
						type: "Int", id: "numberOfLegs", parameters: [],
						block: [.returnStm(5)])]),
				JKRTreeClassDeclaration(
					type: "SomeClass",
					methods: [
						JKRTreeFunctionDeclaration(
							type: "Int", id: "five", parameters: [],
							block: [.returnStm(5)]),
						JKRTreeFunctionDeclaration(
							type: "Int", id: "two", parameters: [],
							block: [.returnStm(2)])])
				])

			let files = try translate(tree)

			// TEST: Files get created with correct contents
			for (filename, contents) in files {
				let expectedContents = try String(
					contentsOfFile: "\(testFilesPath)\(testName)/\(filename)")
				XCTAssertEqual(contents, expectedContents,
				               "Translation failed in file \(filename)")
			}

			// TEST: No other files get created
			XCTAssertEqual(files.count, 3)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
