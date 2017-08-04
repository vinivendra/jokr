import XCTest

class FunctionListenerTests: XCTestCase {
	func testContains() {
		let program = JokrParser.ProgramContext()
		let assign = JokrParser.AssignmentContext()
		let variableDeclaration = JokrParser.VariableDeclarationContext()
		program.addChild(assign)
		assign.addChild(variableDeclaration)

		XCTAssert(program.contains {
			return $0 is JokrParser.AssignmentContext
		})

		XCTAssert(program.contains {
			return $0 is JokrParser.VariableDeclarationContext
		})

		XCTAssertFalse(program.contains {
			return $0 is JokrParser.ExpressionContext
		})
	}

	func testFilter() {
		let program = JokrParser.ProgramContext()
		let assign = JokrParser.AssignmentContext()
		let variableDeclaration = JokrParser.VariableDeclarationContext()
		program.addChild(assign)
		assign.addChild(variableDeclaration)

		let innerRules = program.filter { !($0 is JokrParser.ProgramContext) }
		let assignRules = program.filter { $0 is JokrParser.AssignmentContext }

		XCTAssertEqual(innerRules.count, 2)
		XCTAssert(innerRules.contains { $0 === assign })
		XCTAssert(innerRules.contains { $0 === variableDeclaration })

		XCTAssertEqual(assignRules.count, 1)
		XCTAssert(assignRules.contains { $0 === assign })
	}

	func testFilterType() {
		let program = JokrParser.ProgramContext()
		let assign1 = JokrParser.AssignmentContext()
		let assign2 = JokrParser.AssignmentContext()
		program.addChild(assign1)
		program.addChild(assign2)

		let assignRules: [JokrParser.AssignmentContext] = program.filter(
			type: JokrParser.AssignmentContext.self)

		XCTAssertEqual(assignRules.count, 2)
		XCTAssert(assignRules.contains { $0 === assign1 })
		XCTAssert(assignRules.contains { $0 === assign2 })
	}
}
