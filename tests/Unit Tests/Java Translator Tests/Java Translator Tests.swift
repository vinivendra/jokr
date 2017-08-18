import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Java Translator Tests/"

private let errorMessage =
	"Lexer, Parser or Translator failed during test.\nError: "

////////////////////////////////////////////////////////////////////////////////
// swiftlint:disable line_length
let emptyMainContents = "public class Main {\n\tpublic static void main(String []args) {\n\t}\n}\n"
let assignmentMainContents = "public class Main {\n\tpublic static void main(String []args) {\n\t\tint x = 2;\n\t\tint y = x + x;\n\t\tfloat z = y - x;\n\t}\n}\n"
// swiftlint:enable line_length

////////////////////////////////////////////////////////////////////////////////
class JavaTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(
		file filename: String) throws -> [String: String] {
		do {
			let program = try parser.parse(file: testFilesPath + filename)
			let writer = JKRStringWriter()
			let translator = JKRJavaTranslator(writingWith: writer)
			try translator.translate(program: program)
			writer.prettyPrint()
			return writer.files
		}
		catch (let error) {
			throw error
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: - Tests

	func testEmpty() {
		do {
			// WITH:
			let files = try translate(file: "TestEmpty.jkr")

			// TEST: Empty main file gets created
			XCTAssertEqual(files["Main.java"], emptyMainContents)

			// TEST: No other files get created
			XCTAssertEqual(files.count, 1)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testAssignments() {
		do {
			// WITH:
			let files = try translate(file: "TestAssignments.jkr")

			// TEST: Empty main file gets created
			XCTAssertEqual(files["Main.java"], assignmentMainContents)

			// TEST: No other files get created
			XCTAssertEqual(files.count, 1)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
