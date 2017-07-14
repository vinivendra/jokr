import Antlr4

class JKRContainsFunction: ParseTreeListener {
	var result = false
	var predicate: (ParserRuleContext) -> Bool

	init(_ predicate: @escaping (ParserRuleContext) -> Bool) {
		self.predicate = predicate
	}

	func enterEveryRule(_ ctx: ParserRuleContext) {
		result = result || predicate(ctx)
	}

	func visitTerminal(_ node: Antlr4.TerminalNode) { }
	func visitErrorNode(_ node: Antlr4.ErrorNode) { }
	func exitEveryRule(_ ctx: Antlr4.ParserRuleContext) throws { }
}

class JKRFilterFunction: ParseTreeListener {
	var result = [ParserRuleContext]()
	var predicate: (ParserRuleContext) -> Bool

	init(_ predicate: @escaping (ParserRuleContext) -> Bool) {
		self.predicate = predicate
	}

	func enterEveryRule(_ ctx: ParserRuleContext) {
		if predicate(ctx) {
			result.append(ctx)
		}
	}

	func visitTerminal(_ node: Antlr4.TerminalNode) { }
	func visitErrorNode(_ node: Antlr4.ErrorNode) { }
	func exitEveryRule(_ ctx: Antlr4.ParserRuleContext) throws { }
}

extension ParserRuleContext {
	func contains(where predicate: @escaping (ParserRuleContext) -> Bool)
		-> Bool
	{
		let listener = JKRContainsFunction(predicate)

		// JKRContainsFunction's only throwing function is empty
		try! ParseTreeWalker.DEFAULT.walk(listener, self)

		return listener.result
	}

	func filter(where predicate: @escaping (ParserRuleContext) -> Bool)
		-> [ParserRuleContext]
	{
		let listener = JKRFilterFunction(predicate)

		// JKRContainsFunction's only throwing function is empty
		try! ParseTreeWalker.DEFAULT.walk(listener, self)

		return listener.result
	}
}
