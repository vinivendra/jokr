import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Java Translator Tests/"

private let errorMessage =
	"Lexer, Parser or Translator failed during test.\nError: "

////////////////////////////////////////////////////////////////////////////////
private let assignmentMainContents =
"""
public class Main {
	public static void main(String []args) {
		int x = 2;
		int y = x + x;
		float z = y - x;
		y = (z + x) - y;
	}
}

"""

private let functionCallMainContents =
"""
public class Main {
	public static void main(String []args) {
		System.out.format(\"Hello jokr!\\n\");
		System.out.format(\"%d\\n\", 1);
		System.out.format(\"%d %d\\n\", 1, 2);
	}
}

"""

private let classDeclarationPersonContents =
"""
public class Person {
}

"""
private let classDeclarationAnimalContents =
"""
public class Animal {
}

"""

////////////////////////////////////////////////////////////////////////////////
class JavaTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(
		file filename: String) throws -> [String: String] {
		do {
			guard let tree = try parser.parse(file: testFilesPath + filename)
				else
			{
				XCTFail("Failed to parse file \(filename)")
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
