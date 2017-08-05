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

		let expectedTexts = ["foo", "bar", "baz", "bla", "hue"]

		XCTAssertEqual(ids, expectedIDs)

		for (id, differentID) in zip(ids, expectedIDs.shifted()) {
			XCTAssertNotEqual(id, differentID)
		}

		XCTAssertEqual(ids.map { $0.text }, expectedTexts)
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

		let expectedTexts = ["Foo", "Bar", "Baz", "Bla", "Hue"]

		XCTAssertEqual(types, expectedTypes)

		for (type, differentType) in zip(types, expectedTypes.shifted()) {
			XCTAssertNotEqual(type, differentType)
		}

		XCTAssertEqual(types.map { $0.text }, expectedTexts)
	}

	func testParameters() {
		let parameters: [JKRTreeParameter] = [
			JKRTreeParameter(type: "Int", id: "x"),
			JKRTreeParameter(type: "Person", id: "x"),
			JKRTreeParameter(type: "Person", id: "joe")
		]

		let expectedParameters: [JKRTreeParameter] = [
			JKRTreeParameter(type: "Int", id: "x"),
			JKRTreeParameter(type: "Person", id: "x"),
			JKRTreeParameter(type: "Person", id: "joe")
		]

		XCTAssertEqual(parameters, expectedParameters)

		for (parameter, differentParameter) in
			zip(parameters, expectedParameters.shifted())
		{
			XCTAssertNotEqual(parameter, differentParameter)
		}
	}

	func testFunctionDeclarations() {
		let declarations = [
			JKRTreeFunctionDeclaration(
				type: "Int", id: "func1",
				parameters: [],
				block: [.returnStm(.int("0"))]),
			JKRTreeFunctionDeclaration(
				type: "Void", id: "func1",
				parameters: [],
				block: [.returnStm(.int("0"))]),
			JKRTreeFunctionDeclaration(
				type: "Void", id: "func2",
				parameters: [],
				block: [.returnStm(.int("0"))]),
			JKRTreeFunctionDeclaration(
				type: "Void", id: "func2",
				parameters: [JKRTreeParameter(type: "Int", id: "bla")],
				block: [.returnStm(.int("0"))]),
			JKRTreeFunctionDeclaration(
				type: "Void", id: "func2",
				parameters: [JKRTreeParameter(type: "Int", id: "bla")],
				block: [.returnStm(.int("1"))]),
		]

		let expectedDeclarations = declarations.map { $0 }

		XCTAssertEqual(declarations, expectedDeclarations)

		for (declaration, differentDeclaration) in
			zip(declarations, expectedDeclarations.shifted())
		{
			XCTAssertNotEqual(declaration, differentDeclaration)
		}

	}
}
