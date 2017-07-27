import Antlr4

class JKRTranspiler {
	private let dataSource: JKRLanguageDataSource

	init(language: JKRLanguageDataSource) {
		self.dataSource = language
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	func stringForFileStart() -> String {
		return dataSource.stringForFileStart()
	}

	func transpileAssignment(_ assignment: JokrParser.AssignmentContext)
		-> String
	{
		if let variableDeclaration = assignment.variableDeclaration(),
			let expression = assignment.expression()
		{
			let type = transpileType(variableDeclaration.TYPE())
			let id = transpileID(variableDeclaration.ID())
			let expressionText = transpileExpression(expression)
			return "\(type)\(id) = \(expressionText);\n"
		}
		else if let lvalue = assignment.lvalue(),
			let expression = assignment.expression()
		{
			let id = transpileID(lvalue.ID())
			let expressionText = transpileExpression(expression)
			return "\(id) = \(expressionText);\n"
		}
		else
		{
			assertionFailure("Failed to transpile assignment")
			return ""
		}
	}

	func transpileFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext) -> String
	{
		let (type, id, parameters) = unwrapFunctionDeclarationContext(ctx)
		return dataSource.stringForFunctionHeader(
			withType: type,
			id: id,
			parameters: parameters)
	}

	func transpileReturn(_ ctx: JokrParser.ReturnStatementContext) -> String {
		let expression = transpileExpression(ctx.expression()!)
		return "return \(expression);\n"
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private func transpileType(_ type: TerminalNode?) -> String {
		if let text = type?.getSymbol()?.getText() {
			return dataSource.spacedStringForType(text)
		}

		assertionFailure("Failed to transpile type")
		return ""
	}

	private func transpileID(_ id: TerminalNode?) -> String {
		if let text = id?.getSymbol()?.getText() {
			return dataSource.stringForID(text)
		}

		assertionFailure("Failed to transpile id")
		return ""
	}

	private func transpileExpression(_ expression: JokrParser.ExpressionContext)
		-> String
	{
		if let int = expression.INT()?.getText() {
			return dataSource.stringForInt(int)
		}
		else if expression.LPAREN() != nil,
			let expression = expression.expression(0) {
			return "(\(transpileExpression(expression)))"
		}
		else if let operatorText = expression.OPERATOR()?.getText(),
			let lhs = expression.expression(0),
			let rhs = expression.expression(1) {
			let lhsText = transpileExpression(lhs)
			let rhsText = transpileExpression(rhs)
			return "\(lhsText) \(operatorText) \(rhsText)"
		}
		else if let lvalue = expression.lvalue() {
			return transpileID(lvalue.ID())
		}

		assertionFailure("Failed to transpile expression")
		return ""
	}

	private func transpileParameter(
		_ ctx: JokrParser.ParameterDeclarationContext) ->
		(type: String, id: String)
	{
		return (dataSource.stringForType(ctx.TYPE()!.getText()),
		        dataSource.stringForID(ctx.ID()!.getText()))
	}


	private func unwrapFunctionDeclarationContext(
		_ ctx: JokrParser.FunctionDeclarationContext) ->
		(type: String,
		id: String,
		parameters: [(type: String, id: String)])
	{
		if let functionHeader = ctx.functionDeclarationHeader(),
			let functionParameters = ctx.functionDeclarationParameters(),
			let parameterList = functionParameters.parameterDeclarationList()
		{
			let type = dataSource.stringForType(
				functionHeader.TYPE()!.getText())
			let id = dataSource.stringForID(functionHeader.ID()!.getText())
			let parameters = parameterList.parameters().map(transpileParameter)

			return (type, id, parameters)
		} else {
			assertionFailure("Failed to transpile function declaration")
			return ("", "", [])
		}
	}
}
