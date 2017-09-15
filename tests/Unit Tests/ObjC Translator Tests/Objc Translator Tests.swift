import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Objc Translator Tests/"

private let errorMessage =
"""
Lexer, Parser or Translator failed during test.
Error:
"""

// TODO: There shouldn't be these extra brackets after @end's in either .m or .h
// files.

////////////////////////////////////////////////////////////////////////////////
class ObjCTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(_ testName: String) throws -> [String: String] {
		do {
			guard let tree = try parser.parse(file:
				"\(testFilesPath)\(testName)/\(testName).jkr")
				else
			{
				XCTFail("Failed to parse file \(testName)")
				throw JKRError.parsing
			}

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
			let files = try translate(testName)

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
			let files = try translate(testName)

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
			let files = try translate(testName)

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
