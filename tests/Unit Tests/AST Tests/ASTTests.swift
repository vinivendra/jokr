import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr To Jokr Tests/"

class ASTTests: XCTestCase {
	func testIDs() {
		// WITH:
		let ids: [JKRTreeID] = [
			JKRTreeID("foo"),
			JKRTreeID(stringLiteral: "bar"),
			JKRTreeID(extendedGraphemeClusterLiteral: "baz"),
			JKRTreeID(unicodeScalarLiteral: "bla"),
			"hue"
		]

		let expectedTexts = ["foo", "bar", "baz", "bla", "hue"]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(ids, ids.arrayCopy())

		// TEST: == fails on different instances
		for (id, differentID) in zip(ids, ids.shifted()) {
			XCTAssertNotEqual(id, differentID)
		}

		// TEST: data is initialized, stored and retrieved as expected
		XCTAssertEqual(ids.map { $0.text }, expectedTexts)
	}

	func testTypes() {
		// WITH:
		let types: [JKRTreeType] = [
			JKRTreeType("Foo"),
			JKRTreeType(stringLiteral: "Bar"),
			JKRTreeType(extendedGraphemeClusterLiteral: "Baz"),
			JKRTreeType(unicodeScalarLiteral: "Bla"),
			"Hue"
		]

		let expectedTexts = ["Foo", "Bar", "Baz", "Bla", "Hue"]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(types, types.arrayCopy())

		// TEST: == fails on different instances
		for (type, differentType) in zip(types, types.shifted()) {
			XCTAssertNotEqual(type, differentType)
		}

		// TEST: data is initialized, stored and retrieved as expected
		XCTAssertEqual(types.map { $0.text }, expectedTexts)
	}

	func testParameters() {
		// WITH:
		let parameters: [JKRTreeParameter] = [
			JKRTreeParameter(type: "Int", id: "x"),
			JKRTreeParameter(type: "Person", id: "x"),
			JKRTreeParameter(type: "Person", id: "joe")
		]

		let expectedData: [(type: JKRTreeType, id: JKRTreeID)] =
			[("Int", "x"), ("Person", "x"), ("Person", "joe")]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(parameters, parameters.arrayCopy())

		// TEST: == fails on different instances
		for (parameter, differentParameter) in
			zip(parameters, parameters.shifted())
		{
			XCTAssertNotEqual(parameter, differentParameter)
		}

		// TEST: data is initialized, stored and retrieved as expected
		XCTAssertEqual(parameters.map { $0.type }, expectedData.map { $0.type })
		XCTAssertEqual(parameters.map { $0.id }, expectedData.map { $0.id })
	}

	func testExpressions() {
		// WITH:
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

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(expressions, expressions.arrayCopy())

		// TEST: == fails on different instances
		for (expression, differentExpression) in
			zip(expressions, expressions.shifted())
		{
			XCTAssertNotEqual(expression, differentExpression)
		}
	}

	func testAssignments() {
		// WITH:
		let assignments: [JKRTreeAssignment] = [
			.declaration("Int", "x", .int("0")),
			.declaration("Float", "x", .int("0")),
			.declaration("Float", "y", .int("0")),
			.declaration("Float", "x", .int("1")),
			.assignment("x", .int("0")),
			.assignment("y", .int("0")),
			.assignment("y", .int("1"))
		]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(assignments, assignments.arrayCopy())

		// TEST: == fails on different instances
		for (assignment, differentAssignment) in
			zip(assignments, assignments.shifted())
		{
			XCTAssertNotEqual(assignment, differentAssignment)
		}
	}

	func testStatements() {
		// WITH:
		let statements: [JKRTreeStatement] = [
			.assignment(.assignment("y", .int("1"))),
			.assignment(.assignment("y", .int("0"))),
			.returnStm(JKRTreeReturn(.int("0"))),
			.returnStm(JKRTreeReturn(.int("1")))
		]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(statements, statements.arrayCopy())

		// TEST: == fails on different instances
		for (statement, differentStatement) in
			zip(statements, statements.shifted())
		{
			XCTAssertNotEqual(statement, differentStatement)
		}
	}

	func testFunctionDeclarations() {
		let declarations: [JKRTreeFunctionDeclaration] = [
			JKRTreeFunctionDeclaration(
				type: "Int", id: "func1",
				parameters: [],
				block: [.assignment(.assignment("y", .int("1")))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func1",
				parameters: [],
				block: [.assignment(.assignment("y", .int("1")))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [],
				block: [.assignment(.assignment("y", .int("1")))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [JKRTreeParameter(type: "Float", id: "bla")],
				block: [.assignment(.assignment("y", .int("1")))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [JKRTreeParameter(type: "Int", id: "bla")],
				block: [.assignment(.assignment("y", .int("1")))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [JKRTreeParameter(type: "Int", id: "bla")],
				block: [.assignment(.assignment("x", .int("1")))])
		]

		let expectedBlocks: [[JKRTreeStatement]] = [
			[.assignment(.assignment("y", .int("1")))],
			[.assignment(.assignment("y", .int("1")))],
			[.assignment(.assignment("y", .int("1")))],
			[.assignment(.assignment("y", .int("1")))],
			[.assignment(.assignment("y", .int("1")))],
			[.assignment(.assignment("x", .int("1")))]
		]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(declarations, declarations.arrayCopy())

		// TEST: == fails on different instances
		for (declaration, differentDeclaration) in
			zip(declarations, declarations.shifted())
		{
			XCTAssertNotEqual(declaration, differentDeclaration)
		}

		// TEST: blocks are initialized, stored and retrieved as expected
		for (block, expectedBlock) in
			zip(declarations.map { $0.block }, expectedBlocks)
		{
			XCTAssertEqual(block, expectedBlock)
		}
	}
}
