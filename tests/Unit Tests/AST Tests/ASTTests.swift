import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr To Jokr Tests/"

class ASTTests: XCTestCase {
	func testIDs() {
		let ids: [JKRTreeID] = [
			JKRTreeID("foo"),
			JKRTreeID(stringLiteral: "bar"),
			JKRTreeID(extendedGraphemeClusterLiteral: "baz"),
			JKRTreeID(unicodeScalarLiteral: "bla"),
			"hue"
		]

		let expectedIDs: [JKRTreeID] = ["foo", "bar", "baz", "bla",
		                                JKRTreeID("hue")]

		XCTAssertEqual(ids, expectedIDs)

		for (id, differentID) in zip(ids, expectedIDs.shifted()) {
			XCTAssertNotEqual(id, differentID)
		}
	}

	func testTypes() {
		let types: [JKRTreeType] = [
			JKRTreeType("Foo"),
			JKRTreeType(stringLiteral: "Bar"),
			JKRTreeType(extendedGraphemeClusterLiteral: "Baz"),
			JKRTreeType(unicodeScalarLiteral: "Bla"),
			"Hue"
		]

		let expectedTypes: [JKRTreeType] = ["Foo", "Bar", "Baz", "Bla",
		                                    JKRTreeType("Hue")]

		XCTAssertEqual(types, expectedTypes)

		for (type, differentType) in zip(types, expectedTypes.shifted()) {
			XCTAssertNotEqual(type, differentType)
		}
	}
}
