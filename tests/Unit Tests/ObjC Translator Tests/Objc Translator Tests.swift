import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Objc Translator Tests/"

private let errorMessage =
	"Lexer, Parser or Translator failed during test.\nError: "

////////////////////////////////////////////////////////////////////////////////
// swiftlint:disable line_length
private let assignmentMainContents = "#import <Foundation/Foundation.h>\n\nint main(int argc, const char * argv[]) {\n\t@autoreleasepool {\n\t\tint x = 2;\n\t\tint y = x + x;\n\t\tfloat z = y - x;\n\t\ty = (z + x) - y;\n\t}\n\treturn 0;\n}\n"

private let functionCallMainContents = "#import <Foundation/Foundation.h>\n\nint main(int argc, const char * argv[]) {\n\t@autoreleasepool {\n\t\tNSLog(@\"Hello jokr!\\n\");\n\t\tNSLog(@\"%d\\n\", 1);\n\t\tNSLog(@\"%d %d\\n\", 1, 2);\n\t}\n\treturn 0;\n}\n"

private let classDeclarationPersonHContents = "#import <Foundation/Foundation.h>\n\n@interface Person : NSObject\n\n@end\n}\n"
private let classDeclarationPersonMContents = "#import \"Person.h\"\n\n@implementation Person\n\n@end\n}\n"
private let classDeclarationAnimalHContents = "#import <Foundation/Foundation.h>\n\n@interface Animal : NSObject\n\n@end\n}\n"
private let classDeclarationAnimalMContents = "#import \"Animal.h\"\n\n@implementation Animal\n\n@end\n}\n"
// swiftlint:enable line_length

////////////////////////////////////////////////////////////////////////////////
class ObjCTranslatorTests: XCTestCase {
	let parser = JKRAntlrParser()

	func translate(
		file filename: String) throws -> [String: String] {
		do {
			let program = try parser.parse(file: testFilesPath + filename)
			let writer = JKRStringWriter()
			let translator = JKRObjcTranslator(writingWith: writer)
			try translator.translate(program: program)
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
			XCTAssertEqual(files["main.m"], assignmentMainContents)

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
			let files = try translate(file: "TestFunctionCalls.jkr")

			// TEST: Main file gets created with correct contents
			XCTAssertEqual(files["main.m"], functionCallMainContents)

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
			XCTAssertEqual(files["Person.h"], classDeclarationPersonHContents)
			// TEST: Person file gets created with correct contents
			XCTAssertEqual(files["Person.m"], classDeclarationPersonMContents)

			// TEST: Animal file gets created with correct contents
			XCTAssertEqual(files["Animal.h"], classDeclarationAnimalHContents)
			// TEST: Animal file gets created with correct contents
			XCTAssertEqual(files["Animal.m"], classDeclarationAnimalMContents)

			// TEST: No other files get created
			XCTAssertEqual(files.count, 4)
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
