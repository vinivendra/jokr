import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/JKRParser Tests/"

class JKRParserTests: XCTestCase {
	let implementationsToTest = [JKRAntlrParser()]

	func testEmpty() {
		for parser in implementationsToTest {
			do {
				// WITH:
				let tree = try parser.parse(
					file: testFilesPath + "TestEmpty.jkr")

				// TEST: Empty file should return nil
				XCTAssertNil(tree)
			}
			catch (let error) {
				XCTFail("Parser \(parser) threw an error: \(error)")
			}
		}
	}

	func testStatements() {
		for parser in implementationsToTest {
			do {
				// WITH:
				guard let tree =
					try parser.parse(file: testFilesPath + "TestStatements.jkr")
					else
				{
					XCTFail("Parser \(parser) returned nil for non-empty file.")
					continue
				}

				// TEST: File with top level statements should return a
				// .statement case
				switch tree {
				case JKRTree.statements(_): break
				default: XCTFail("Parser \(parser) failed the test.")
				}
			}
			catch (let error) {
				XCTFail("Parser \(parser) threw an error: \(error)")
			}
		}
	}

	func testDeclarations() {
		for parser in implementationsToTest {
			do {
				// WITH:
				guard let tree =
					try parser.parse(
						file: testFilesPath + "TestDeclarations.jkr")
					else
				{
					XCTFail("Parser \(parser) returned nil for non-empty file.")
					continue
				}

				// TEST: File with top level declarations should return a
				// .declaration case
				switch tree {
				case JKRTree.declarations(_): break
				default: XCTFail("Parser \(parser) failed the test.")
				}
			}
			catch (let error) {
				XCTFail("Parser \(parser) threw an error: \(error)")
			}
		}
	}
}
