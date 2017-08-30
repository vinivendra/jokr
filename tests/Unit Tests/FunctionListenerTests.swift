import XCTest

class FunctionListenerTests: XCTestCase {
	func testContains() {
		// WITH:
		let program = JokrParser.ProgramContext()
		let assign = JokrParser.AssignmentContext()
		let variableDeclaration = JokrParser.VariableDeclarationContext()
		program.addChild(assign)
		assign.addChild(variableDeclaration)

		// TEST: `contains` finds existing contexts
		XCTAssert(program.contains {
			return $0 is JokrParser.AssignmentContext
		})
		XCTAssert(program.contains {
			return $0 is JokrParser.VariableDeclarationContext
		})

		// TEST: `contains` doesn't find non-existing contexts
		XCTAssertFalse(program.contains {
			return $0 is JokrParser.ExpressionContext
		})
	}

	func testFilter() {
		// WITH:
		let program = JokrParser.ProgramContext()
		let assign = JokrParser.AssignmentContext()
		let variableDeclaration = JokrParser.VariableDeclarationContext()
		program.addChild(assign)
		assign.addChild(variableDeclaration)

		let innerRules = program.filter { !($0 is JokrParser.ProgramContext) }
		let assignRules = program.filter { $0 is JokrParser.AssignmentContext }

		// TEST: Filtered results contain expected contexts
		XCTAssert(innerRules.contains { $0 === assign })
		XCTAssert(innerRules.contains { $0 === variableDeclaration })
		XCTAssert(assignRules.contains { $0 === assign })

		// TEST: Filtered results don't contain unexpected contexts
		XCTAssertEqual(assignRules.count, 1)
		XCTAssertEqual(innerRules.count, 2)
	}

	func testFilterType() {
		// WITH:
		let program = JokrParser.ProgramContext()
		let assign1 = JokrParser.AssignmentContext()
		let assign2 = JokrParser.AssignmentContext()
		program.addChild(assign1)
		program.addChild(assign2)

		let assignRules: [JokrParser.AssignmentContext] = program.filter(
			type: JokrParser.AssignmentContext.self)

		// TEST: Filtered results contain expected contexts
		XCTAssert(assignRules.contains { $0 === assign1 })
		XCTAssert(assignRules.contains { $0 === assign2 })

		// TEST: Filtered results don't contain unexpected contexts
		XCTAssertEqual(assignRules.count, 2)
	}
}
