/// Stateless class that converts the jokr AST nodes into bits of code. Manually
/// handles code that is common to both Objc and Java, which is mostly just the
/// general structure; all other language-specific code is delegated into
/// the language data source.
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
		_ functionDeclaration: JKRTreeFunctionDeclaration) -> String
	{
		return dataSource.stringForFunctionHeader(
			withType: functionDeclaration.type,
			id: functionDeclaration.id,
			parameters: functionDeclaration.parameters)
	}

	func transpileReturn(_ expression: JKRTreeExpression) -> String {
		let expression = transpileExpression(expression)
		return "return \(expression);\n"
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private func transpileType(_ text: JKRTreeType) -> String {
		return dataSource.spacedStringForType(text)
	}

	private func transpileID(_ text: JKRTreeID) -> String {
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
}
