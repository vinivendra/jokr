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

	func transpileAssignment(_ assignment: JKRTreeAssignment)
		-> String
	{
		switch assignment {
		case let .declaration(type, id, expression):
			let typeText = transpileType(type)
			let idText = transpileID(id)
			let expressionText = transpileExpression(expression)
			return "\(typeText)\(idText) = \(expressionText);\n"
		case let .assignment(id, expression):
			let idText = transpileID(id)
			let expressionText = transpileExpression(expression)
			return "\(idText) = \(expressionText);\n"
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

	func transpileReturn(_ expression: JKRTreeExpression) -> String {
		let expression = transpileExpression(expression)
		return "return \(expression);\n"
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private func transpileType(_ text: String) -> String {
		return dataSource.spacedStringForType(text)
	}

	private func transpileID(_ text: String) -> String {
		return dataSource.stringForID(text)
	}

	private func transpileExpression(_ expression: JKRTreeExpression)
		-> String
	{
		switch expression {
		case let .int(text):
			return dataSource.stringForInt(text)
		case let .parenthesized(innerExpression):
			let innerExpressionText = transpileExpression(innerExpression)
			return "(\(innerExpressionText))"
		case let .operation(leftExpression, operatorText, rightExpression):
			let leftText = transpileExpression(leftExpression)
			let rightText = transpileExpression(rightExpression)
			return "\(leftText) \(operatorText) \(rightText)"
		case let .lvalue(text):
			return transpileID(text)
		}
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
