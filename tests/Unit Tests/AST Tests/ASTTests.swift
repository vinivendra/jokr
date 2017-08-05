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

		let expectedIDs = ids.arrayCopy()

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

		let expectedTypes = types.arrayCopy()

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

		let expectedParameters = parameters.arrayCopy()

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

		let expectedDeclarations = declarations.arrayCopy()

		XCTAssertEqual(declarations, expectedDeclarations)

		for (declaration, differentDeclaration) in
			zip(declarations, expectedDeclarations.shifted())
		{
			XCTAssertNotEqual(declaration, differentDeclaration)
		}
	}


	func testExpressions() {
		let expressions: [JKRTreeExpression] = [
			JKRTreeExpression.int("0"), .int("1"),
			.parenthesized(.int("0")), .parenthesized(.int("1")),
			.operation(.int("0"), "+", .int("1")),
			.operation(.int("1"), "+", .int("1")),
			.operation(.int("1"), "-", .int("1")),
			.operation(.int("1"), "-", .int("2")),
			JKRTreeExpression.lvalue("foo"),
			JKRTreeExpression.lvalue("bar")
			]

		let expectedExpression = expressions.arrayCopy()

		XCTAssertEqual(expressions, expectedExpression)

		for (expression, differentExpression) in
			zip(expressions, expectedExpression.shifted())
		{
			XCTAssertNotEqual(expression, differentExpression)
		}
	}
}
