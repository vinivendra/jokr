import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Java Translator Tests/"

private let errorMessage =
	"Lexer, Parser or Translator failed during test.\nError: "

////////////////////////////////////////////////////////////////////////////////
class JavaTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(_ tree: JKRTree) throws -> [String: String] {
		do {
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
			let expectedResultsFolder = "TestAssignments"

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
				let expectedContents = try String(contentsOfFile:
					"\(testFilesPath)\(expectedResultsFolder)/\(filename)")
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
			let expectedResultsFolder = "TestFunctionCalls"

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
				let expectedContents = try String(contentsOfFile:
					"\(testFilesPath)\(expectedResultsFolder)/\(filename)")
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
			let expectedResultsFolder = "TestClassDeclarations"

			let tree = JKRTree.declarations([
				.classDeclaration(JKRTreeClassDeclaration(type: "Person")),
				.classDeclaration(JKRTreeClassDeclaration(type: "Animal"))
				])

			let files = try translate(tree)

			// TEST: Files get created with correct contents
			for (filename, contents) in files {
				let expectedContents = try String(contentsOfFile:
					"\(testFilesPath)\(expectedResultsFolder)/\(filename)")
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
