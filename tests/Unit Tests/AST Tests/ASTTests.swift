import Antlr4
import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/Antlr To Jokr Tests/"

class ASTTests: XCTestCase {

	func testStatements() {
		// WITH:
		let statements: [JKRTreeStatement] = [
			.assignment(.assignment("y", 1)),
			.assignment(.assignment("y", 0)),
			.functionCall(JKRTreeFunctionCall(id: "f")),
			.functionCall(JKRTreeFunctionCall(id: "methodName")),
			.functionCall(JKRTreeFunctionCall(id: "methodName",
			                                  parameters: [1])),
			.returnStm(0),
			.returnStm(1)
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

	func testOperators() {
		// WITH:
		let operators: [JKRTreeOperator] = [
			JKRTreeOperator("+"),
			JKRTreeOperator(stringLiteral: "-"),
			JKRTreeOperator(extendedGraphemeClusterLiteral: "/"),
			JKRTreeOperator(unicodeScalarLiteral: "*"),
			">>"
		]

		let expectedOperators = ["+", "-", "/", "*", ">>"]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(operators, operators.arrayCopy())

		// TEST: == fails on different instances
		for (op, differentOp) in zip(operators, operators.shifted()) {
			XCTAssertNotEqual(op, differentOp)
		}

		// TEST: data is initialized, stored and retrieved as expected
		XCTAssertEqual(operators.map { $0.text }, expectedOperators)
	}

	func testExpressions() {
		// WITH:
		let expressions: [JKRTreeExpression] = [
			JKRTreeExpression.lvalue("foo"),
			JKRTreeExpression.lvalue("bar"),
			JKRTreeExpression.int(0),
			JKRTreeExpression.int(1),
			JKRTreeExpression.parenthesized(0),
			JKRTreeExpression.parenthesized(1),
			.operation(0, "+", 1),
			.operation(1, "+", 1),
			.operation(1, "-", 1),
			.operation(1, "-", 2)
		]

		let literalExpessions: [JKRTreeExpression] = [
			JKRTreeExpression(integerLiteral: 1),
			4,
			JKRTreeExpression(stringLiteral: "foo"),
			JKRTreeExpression(extendedGraphemeClusterLiteral: "bar"),
			JKRTreeExpression(unicodeScalarLiteral: "foo"),
			"bar"
		]

		let expectedLiteralExpressions: [JKRTreeExpression] = [
			JKRTreeExpression.int(1),
			JKRTreeExpression.int(4),
			.lvalue("foo"), .lvalue("bar"), .lvalue("foo"), .lvalue("bar")
		]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(expressions, expressions.arrayCopy())

		// TEST: == fails on different instances
		for (expression, differentExpression) in
			zip(expressions, expressions.shifted())
		{
			XCTAssertNotEqual(expression, differentExpression)
		}

		// TEST: Literal instances are created successfully
		XCTAssertEqual(literalExpessions, expectedLiteralExpressions)
	}

	func testAssignments() {
		// WITH:
		let assignments: [JKRTreeAssignment] = [
			.declaration("Int", "x", 0),
			.declaration("Float", "x", 0),
			.declaration("Float", "y", 0),
			.declaration("Float", "x", 1),
			.assignment("x", 0),
			.assignment("y", 0),
			.assignment("y", 1)
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

	func testFunctionCalls() {
		// WITH:
		let functionCalls: [JKRTreeFunctionCall] = [
			JKRTreeFunctionCall(id: "print"),
			JKRTreeFunctionCall(id: "f"),
			JKRTreeFunctionCall(id: "f", parameters: [1]),
			JKRTreeFunctionCall(id: "f", parameters: [1, 2])
		]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(functionCalls, functionCalls.arrayCopy())

		// TEST: == fails on different instances
		for (functionCall, differentFunctionCall) in
			zip(functionCalls, functionCalls.shifted())
		{
			XCTAssertNotEqual(functionCall, differentFunctionCall)
		}
	}

	func testParameterDeclarations() {
		// WITH:
		let parameters: [JKRTreeParameterDeclaration] = [
			JKRTreeParameterDeclaration(type: "Int", id: "x"),
			JKRTreeParameterDeclaration(type: "Person", id: "x"),
			JKRTreeParameterDeclaration(type: "Person", id: "joe")
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

	func testFunctionDeclarations() {
		let declarations: [JKRTreeFunctionDeclaration] = [
			JKRTreeFunctionDeclaration(
				type: "Int", id: "func1",
				parameters: [],
				block: [.assignment(.assignment("y", 1))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func1",
				parameters: [],
				block: [.assignment(.assignment("y", 1))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [],
				block: [.assignment(.assignment("y", 1))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [JKRTreeParameterDeclaration(type: "Float", id: "bla")],
				block: [.assignment(.assignment("y", 1))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [JKRTreeParameterDeclaration(type: "Int", id: "bla")],
				block: [.assignment(.assignment("y", 1))]),
			JKRTreeFunctionDeclaration(
				type: "Float", id: "func2",
				parameters: [JKRTreeParameterDeclaration(type: "Int", id: "bla")],
				block: [.assignment(.assignment("x", 1))])
		]

		let expectedBlocks: [[JKRTreeStatement]] = [
			[.assignment(.assignment("y", 1))],
			[.assignment(.assignment("y", 1))],
			[.assignment(.assignment("y", 1))],
			[.assignment(.assignment("y", 1))],
			[.assignment(.assignment("y", 1))],
			[.assignment(.assignment("x", 1))]
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

	func testInts() {
		// WITH:
		let ints: [JKRTreeInt] = [
			JKRTreeInt(0),
			JKRTreeInt(integerLiteral: 1),
			2
		]

		let expectedValues = [0, 1, 2]

		// TEST: == succeeds on equal instances (reflexive)
		XCTAssertEqual(ints, ints.arrayCopy())

		// TEST: == fails on different instances
		for (int, differentInt) in zip(ints, ints.shifted()) {
			XCTAssertNotEqual(int, differentInt)
		}

		// TEST: data is initialized, stored and retrieved as expected
		XCTAssertEqual(ints.map { $0.value }, expectedValues)
	}
}
