import XCTest

private class TestClass { }

class ExtensionsTests: XCTestCase {
	func testShift() {
		// WITH:
		let empty = Array([0].dropFirst())

		// TEST: `shifted` changes data as expected
		XCTAssertEqual(empty, empty.shifted())
		XCTAssertEqual([1], [1].shifted())
		XCTAssertEqual([2, 1], [1, 2].shifted())
		XCTAssertEqual([2, 3, 1], [1, 2, 3].shifted())
		XCTAssertEqual([2, 3, 4, 5, 1], [1, 2, 3, 4, 5].shifted())

		// TEST: `shift` is the same as `shifted`
		var original = [1, 2, 3, 4, 5]
		let copy = original
		original.shift()
		XCTAssertEqual(original, copy.shifted())
	}
}
