import XCTest

class ObjcDataSourceTests: XCTestCase {
	let dataSource = JKRObjcDataSource()

	func testFileStart() {
		XCTAssertEqual(
			dataSource.stringForFileStart(),
			"#import <Foundation/Foundation.h>\n\n")
	}

	func testSpacedTypes() {
		XCTAssertEqual(dataSource.spacedStringForType("void"), "void ")
		XCTAssertEqual(dataSource.spacedStringForType("int"), "int ")
		XCTAssertEqual(dataSource.spacedStringForType("String"), "String *")
		XCTAssertEqual(dataSource.spacedStringForType("Object"), "Object *")
		XCTAssertEqual(dataSource.spacedStringForType("Person"), "Person *")
	}

	func testTypes() {
		XCTAssertEqual(dataSource.stringForType("void"), "void")
		XCTAssertEqual(dataSource.stringForType("int"), "int")
		XCTAssertEqual(dataSource.stringForType("String"), "String *")
		XCTAssertEqual(dataSource.stringForType("Object"), "Object *")
		XCTAssertEqual(dataSource.stringForType("Person"), "Person *")
	}

	func testFunctionHeaders() {
		XCTAssertEqual(
			dataSource.stringForFunctionHeader(
				withType: "void", id: "main",
				parameters: []),
			"- (void)main")
		XCTAssertEqual(
			dataSource.stringForFunctionHeader(
				withType: "int", id: "five",
				parameters: []),
			"- (int)five")
		XCTAssertEqual(
			dataSource.stringForFunctionHeader(
				withType: "int", id: "five",
				parameters: [JKRTreeParameter(type: "float", id: "four")]),
			"- (int)five:(float)four")
		XCTAssertEqual(
			dataSource.stringForFunctionHeader(
				withType: "int", id: "five",
				parameters: [JKRTreeParameter(type: "String", id: "three"),
				             JKRTreeParameter(type: "float", id: "four")]),
			"- (int)five:(String *)three four:(float)four")
	}
}
