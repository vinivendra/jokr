// Files dealing with Antlr are allowed to force-unwrap
// swiftlint:disable force_unwrapping

import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Lexer Tests/"

extension Array where Element == Token {
	func filter(byType type: Int) -> [Token] {
		return self.filter { $0.getType() == type }
	}

	func countTokens(ofType type: Int) -> Int {
		return self.filter(byType: type).count
	}
}

class LexerTests: XCTestCase {
	func getTokens(inFile filename: String) throws -> [Token] {
		do {
			let contents = try! String(contentsOfFile: testFilesPath + filename)
			let inputStream = ANTLRInputStream(contents)
			let lexer = JokrLexer(inputStream)
			return try lexer.getAllTokens()
		}
		catch (let error) {
			throw error
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: - Tests

	func testIDs() {
		do {
			// WITH:
			let tokens = try getTokens(inFile: "TestIDs")

			let expectedTokens: [(line: Int, charInLine: Int, text: String)] =
				[(4, 0, "foo"), (4, 4, "bar"), (5, 0, "baz"), (6, 0, "blah"),
				 (7, 0, "b0lah"), (8, 0, "b0l0ah"), (9, 0, "blah0"),
				 (10, 0, "_lah"), (11, 0, "__lah"), (12, 0, "_lah0"),
				 (13, 0, "_la0h0")]

			// TEST: Lexer found all expected tokens (in order)
			for expected in expectedTokens {
				XCTAssert(tokens.contains { token in
					return token.getType() == JokrLexer.ID
						&& token.getLine() == expected.line
						&& token.getCharPositionInLine() == expected.charInLine
						&& token.getText() == expected.text
				}, "Token not found: \(expected)")
			}

			// TEST: Lexer didn't find any other tokens of this type
			XCTAssertEqual(tokens.countTokens(ofType: JokrLexer.ID),
			               expectedTokens.count)
		}
		catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}

	func testTypes() {
		do {
			// WITH:
			let tokens = try getTokens(inFile: "TestTypes")

			let expectedTokens: [(line: Int, charInLine: Int, text: String)] =
				[(4, 0, "Foo"), (4, 4, "Bar"), (5, 0, "Baz"), (6, 0, "Blah"),
				 (7, 0, "B0lah"), (8, 0, "B0l0ah"), (9, 0, "Blah0"),
				 (10, 0, "_Lah"), (11, 0, "__Lah"), (12, 0, "_Lah0"),
				 (13, 0, "_La0h0")]

			// TEST: Lexer found all expected tokens (in order)
			for expected in expectedTokens {
				XCTAssert(tokens.contains { token in
					return token.getType() == JokrLexer.TYPE
						&& token.getLine() == expected.line
						&& token.getCharPositionInLine() == expected.charInLine
						&& token.getText() == expected.text
				}, "Token not found: \(expected)")
			}

			// TEST: Lexer didn't find any other tokens of this type
			XCTAssertEqual(tokens.countTokens(ofType: JokrLexer.TYPE),
			               expectedTokens.count)
		}
		catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}

	func testComments() {
		do {
			// WITH:
			let tokens = try getTokens(inFile: "TestComments")

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

			// TEST: Lexer found all expected tokens (in order)
			for expected in expectedTokens {
				XCTAssert(tokens.contains { token in
					return token.getType() == expected.type
						&& token.getLine() == expected.line
						&& token.getCharPositionInLine() == expected.charInLine
						&& token.getText()!.characters.count == expected.length
				}, "Token not found: \(expected)")
			}

			// TEST: Lexer didn't find any extra comment tokens
			XCTAssertEqual(
				tokens.countTokens(ofType: JokrLexer.BLOCK_COMMENT) +
					tokens.countTokens(ofType: JokrLexer.LINE_COMMENT), 5)

			// TEST: Comments didn't eat any newlines
			XCTAssertEqual(tokens.countTokens(ofType: JokrLexer.NEW_LINE), 5)

		}
		catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}

	func testNewlines() {
		do {
			// WITH:
			let tokens = try getTokens(inFile: "TestNewlines")

			let expectedTokens: [(line: Int, charInLine: Int)] =
				[(1, 59), (2, 37), (3, 25), (4, 46), (5, 50), (6, 7), (7, 3),
				 (8, 4), (9, 5), (10, 7), (11, 5), (12, 14), (13, 8), (14, 5),
				 (15, 8)]

			// TEST: Lexer found all expected tokens (in order)
			for expected in expectedTokens {
				XCTAssert(tokens.contains { token in
					return token.getType() == JokrLexer.NEW_LINE
						&& token.getLine() == expected.line
						&& token.getCharPositionInLine() == expected.charInLine
				}, "Token not found: \(expected)")
			}

			// TEST: Lexer didn't find any other tokens of this type
			XCTAssertEqual(tokens.countTokens(ofType: JokrLexer.NEW_LINE),
			               expectedTokens.count)
		}
		catch (let error) {
			XCTFail("JokrLexer failed to get tokens.\nError: \(error)")
		}
	}
}
