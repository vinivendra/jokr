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
		XCTAssert(innerRules.contains { $0 is JokrParser.AssignmentContext})
		XCTAssert(innerRules.contains {
			$0 is JokrParser.VariableDeclarationContext
		})

		XCTAssertEqual(assignRules.count, 1)
		XCTAssert(innerRules.contains { $0 is JokrParser.AssignmentContext})
	}
}
