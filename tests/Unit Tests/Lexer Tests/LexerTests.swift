import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Unit Tests/Lexer Tests/"

class LexerTests: XCTestCase {
	func testIDs() {
		let contents = try! String(contentsOfFile: testFilesPath + "TestIDs")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)

		do {
			let tokens = try lexer.getAllTokens()
			let ids: [(line: Int, charInLine: Int, text: String)] =
				[(4, 0, "foo"), (4, 4, "bar"), (5, 0, "baz"), (6, 0, "blah"),
				 (7, 0, "b0lah"), (8, 0, "b0l0ah"), (9, 0, "blah0"),
				 (10, 0, "_lah"), (11, 0, "__lah"), (12, 0, "_lah0"),
				 (13, 0, "_la0h0")]

			for id in ids {
				XCTAssert(tokens.contains { token in
					return token.getType() == JokrLexer.ID
						&& token.getLine() == id.line
						&& token.getCharPositionInLine() == id.charInLine
						&& token.getText() == id.text
				}, "Token not found: \(id)")
			}

			XCTAssertEqual(tokens.filter { $0.getType() == JokrLexer.ID }.count,
			               ids.count)
		} catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}

	func testTypes() {
		let contents = try! String(contentsOfFile: testFilesPath + "TestTypes")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)

		do {
			let tokens = try lexer.getAllTokens()
			let types: [(line: Int, charInLine: Int, text: String)] =
				[(4, 0, "Foo"), (4, 4, "Bar"), (5, 0, "Baz"), (6, 0, "Blah"),
				 (7, 0, "B0lah"), (8, 0, "B0l0ah"), (9, 0, "Blah0"),
				 (10, 0, "_Lah"), (11, 0, "__Lah"), (12, 0, "_Lah0"),
				 (13, 0, "_La0h0")]

			for type in types {
				XCTAssert(tokens.contains { token in
					return token.getType() == JokrLexer.TYPE
						&& token.getLine() == type.line
						&& token.getCharPositionInLine() == type.charInLine
						&& token.getText() == type.text
				}, "Token not found: \(type)")
			}

			XCTAssertEqual(tokens.filter { $0.getType() == JokrLexer.TYPE }.count,
			               types.count)
		} catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}

	func testComments() {
		// Ensure there are 5 comments in the file,
		// that id's in the same lines as comments get recognized,
		// that comments don't eat newlines (i.e. there are 5 newline tokens)

		let contents = try! String(contentsOfFile:
			testFilesPath + "TestComments")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)

		do {
			let tokens = try lexer.getAllTokens()

			let expectedTokens:
				[(line: Int, charInLine: Int, length: Int, type: Int)] =
				[(1, 0, 59, JokrLexer.BLOCK_COMMENT),
				 (2, 0, 37, JokrLexer.BLOCK_COMMENT),
				 (3, 0, 25, JokrLexer.LINE_COMMENT),
				 (4, 8, 38, JokrLexer.LINE_COMMENT),
				 (5, 4, 42, JokrLexer.BLOCK_COMMENT),
				 (4, 0, 3, JokrLexer.ID),
				 (4, 4, 3, JokrLexer.ID),
				 (5, 0, 3, JokrLexer.ID),
				 (5, 47, 3, JokrLexer.ID)]

			for aToken in expectedTokens {
				XCTAssert(tokens.contains { token in
					return token.getType() == aToken.type
						&& token.getLine() == aToken.line
						&& token.getCharPositionInLine() == aToken.charInLine
						&& token.getText()!.characters.count == aToken.length
				}, "Token not found: \(aToken)")
			}

			XCTAssertEqual(tokens.filter {
				$0.getType() == JokrLexer.BLOCK_COMMENT
					|| $0.getType() == JokrLexer.LINE_COMMENT
				}.count, 5)
			XCTAssertEqual(tokens.filter {
				$0.getType() == JokrLexer.NEW_LINE
				}.count, 5)

		} catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}

	func testNewlines() {
		let contents = try! String(contentsOfFile: testFilesPath + "TestNewlines")

		let inputStream = ANTLRInputStream(contents)
		let lexer = JokrLexer(inputStream)

		do {
			let tokens = try lexer.getAllTokens()
			let newlines: [(line: Int, charInLine: Int)] =
				[(1, 59), (2, 37), (3, 25), (4, 46), (5, 50), (6, 7), (7, 3),
				 (8, 4), (9, 5), (10, 7), (11, 5), (12, 14), (13, 8), (14, 5),
				 (15, 8)]

			for newline in newlines {
				XCTAssert(tokens.contains { token in
					return token.getType() == JokrLexer.NEW_LINE
						&& token.getLine() == newline.line
						&& token.getCharPositionInLine() == newline.charInLine
				}, "Token not found: \(newline)")
			}

			XCTAssertEqual(tokens.filter {
				$0.getType() == JokrLexer.NEW_LINE
				}.count, newlines.count)
		} catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}
}
