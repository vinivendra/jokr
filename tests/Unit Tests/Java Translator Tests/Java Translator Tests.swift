import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Java Translator Tests/"

private let errorMessage =
	"Lexer, Parser or Translator failed during test.\nError: "

////////////////////////////////////////////////////////////////////////////////
// swiftlint:disable line_length
private let assignmentMainContents = "public class Main {\n\tpublic static void main(String []args) {\n\t\tint x = 2;\n\t\tint y = x + x;\n\t\tfloat z = y - x;\n\t\ty = (z + x) - y;\n\t}\n}\n"

private let functionCallMainContents = "public class Main {\n\tpublic static void main(String []args) {\n\t\tSystem.out.format(\"Hello jokr!\\n\");\n\t\tSystem.out.format(\"%d\\n\", 1);\n\t\tSystem.out.format(\"%d %d\\n\", 1, 2);\n\t}\n}\n"

private let classDeclarationPersonContents = "public class Person {\n}\n"
private let classDeclarationAnimalContents = "public class Animal {\n}\n"
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

			// TEST: No other files get created
			XCTAssertEqual(files.count, 0)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testAssignments() {
		do {
			// WITH:
			let files = try translate(file: "TestAssignments.jkr")

			// TEST: Main file gets created with correct contents
			XCTAssertEqual(files["Main.java"], assignmentMainContents)

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
			let files = try translate(file: "TestFunctionCalls.jkr")

			// TEST: Main file gets created with correct contents
			XCTAssertEqual(files["Main.java"], functionCallMainContents)

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
			let files = try translate(file: "TestClassDeclarations.jkr")

			print(files)

			// TEST: Person file gets created with correct contents
			XCTAssertEqual(files["Person.java"], classDeclarationPersonContents)

			// TEST: Animal file gets created with correct contents
			XCTAssertEqual(files["Animal.java"], classDeclarationAnimalContents)

			// TEST: No other files get created
			XCTAssertEqual(files.count, 2)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
