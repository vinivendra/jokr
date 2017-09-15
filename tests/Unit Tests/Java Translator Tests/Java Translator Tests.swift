import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Java Translator Tests/"

private let errorMessage =
	"Lexer, Parser or Translator failed during test.\nError: "

////////////////////////////////////////////////////////////////////////////////
class JavaTranslatorTests: XCTestCase {
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
			let translator = JKRJavaTranslator(writingWith: writer)
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

	func testFunctionCalls() {
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
			XCTAssertEqual(files.count, 2)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
