import Antlr4

extension JokrParser.ParameterDeclarationListContext {
	func parameters() -> [JokrParser.ParameterDeclarationContext] {
		if let parameter = parameterDeclaration() {
			if let parameterList = parameterDeclarationList() {
				return [parameter] + parameterList.parameters()
			} else {
				return [parameter]
			}
		} else {
			return []
		}
	}
}

class JokrCompilerListener: JokrBaseListener {
	override func enterProgram(_ ctx: JokrParser.ProgramContext) {
//		print("\(#function)")
	}

	override func exitProgram(_ ctx: JokrParser.ProgramContext) {
//		print("\(#function)")
	}

	override func enterEveryRule(_ ctx: ParserRuleContext) {
//		print("\(#function) -> \(ctx)")
	}

	override func exitEveryRule(_ ctx: ParserRuleContext) {
//		print("\(#function) -> \(ctx)")
	}

	override func enterAssignment(_ ctx: JokrParser.AssignmentContext) {
//		print(ctx.children)
	}

	override func enterExpression(_ ctx: JokrParser.ExpressionContext) {
//		print(ctx.getTokens(0))
	}
}
