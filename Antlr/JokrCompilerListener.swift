import Antlr4

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
