import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Objc Translator Tests/"

private let errorMessage =
"""
Lexer, Parser or Translator failed during test.
Error:
"""

// TODO: Consider sending these strings to other files, or (probably better)
// saving expected results in separate files.
////////////////////////////////////////////////////////////////////////////////
private let assignmentMainContents =
"""
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		int x = 2;
		int y = x + x;
		float z = y - x;
		y = (z + x) - y;
	}
	return 0;
}

"""

private let functionCallMainContents =
"""
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		NSLog(@\"Hello jokr!\\n");
		NSLog(@\"%d\\n", 1);
		NSLog(@\"%d %d\\n", 1, 2);
	}
	return 0;
}

"""

// TODO: There shouldn't be these extra brackets after @end's in either .m or .h
// files.
private let classDeclarationPersonHContents =
"""
#import <Foundation/Foundation.h>

@interface Person : NSObject

@end
}

"""
private let classDeclarationPersonMContents =
"""
#import \"Person.h\"

@implementation Person

@end
}

"""
private let classDeclarationAnimalHContents =
"""
#import <Foundation/Foundation.h>

@interface Animal : NSObject

@end
}

"""
private let classDeclarationAnimalMContents =
"""
#import \"Animal.h\"

@implementation Animal

@end
}

"""

////////////////////////////////////////////////////////////////////////////////
class ObjCTranslatorTests: XCTestCase {
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
			let translator = JKRObjcTranslator(writingWith: writer)
			try translator.translate(tree: tree)
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
