import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr To Jokr Tests/"

class AntlrToJokrTests: XCTestCase {
	func testAssignment() {
		let contents = try! String(contentsOfFile:
			testFilesPath + "TestAssignment")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)
		let tokens = CommonTokenStream(lexer)

		do {
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			// TODO: Test filter by type and add filter by type to Parser Tests
			let assignments = tree.filter(type:
				JokrParser.AssignmentContext.self)
				.map { $0.toJKRTreeAssignment() }

			let expectedAssignments: [JKRTreeAssignment] = [
				.declaration("Int", "bla", .int("2")),
				.declaration("Float", "fooBar", .int("3")),
				.declaration("Blah", "baz", .lvalue("fooBar")),
				.assignment("fooBar", .lvalue("bla")),
				.assignment("bla", .int("300"))
			]

			XCTAssertEqual(assignments, expectedAssignments)
		} catch (let error) {
			XCTFail("Lexer or Parser failed during test.\nError: \(error)")
		}
	}
}
