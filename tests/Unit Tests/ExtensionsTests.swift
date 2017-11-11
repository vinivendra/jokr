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

	func testStripNSLogData() {
		let testString = """
			2017-08-30 15:25:55.756033-0300 a.out[1406:50095] Hello jokr!
			2017-08-30 15:25:55.756163-0300 a.out[1406:50095] 1
			2017-08-30 15:25:55.756172-0300 a.out[1406:50095] 1 2
			2017-08-30 15:25:55.756033-0300 a.out[1406:50095] 2017-08-30 \
			15:25:55.756033-0300 a.out[1406:50095]

			"""
		let expectedResult = """
			Hello jokr!
			1
			1 2
			2017-08-30 15:25:55.756033-0300 a.out[1406:50095]

			"""

		XCTAssertEqual(testString.strippingNSLogData(), expectedResult)
	}
}
