import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Objc Translator Tests/"

private let errorMessage =
"""
Lexer, Parser or Translator failed during test.
Error:
"""

////////////////////////////////////////////////////////////////////////////////
class ObjCTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(_ tree: JKRTree) throws -> [String: String] {
		do {
			let writer = JKRStringWriter()
			let translator = JKRObjcTranslator(writingWith: writer)
			try translator.translate(tree: tree)
			writer.prettyPrint()
			return writer.files
		}
		catch (let error) {
			throw error
		}
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

			let tree = JKRTree.declarations([
				.classDeclaration(JKRTreeClassDeclaration(type: "Person")),
				.classDeclaration(JKRTreeClassDeclaration(type: "Animal"))
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
			XCTAssertEqual(files.count, 4)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
