/// Stateless class that translates the jokr AST nodes into bits of code.
/// Manually handles code that is common to both Objc and Java, which is mostly
/// just the general structure; all other language-specific code is delegated
/// into the language data source.
class JKRTranslator {
	private let dataSource: JKRLanguageDataSource

	init(language: JKRLanguageDataSource) {
		self.dataSource = language
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	func stringForFileStart() -> String {
		return dataSource.stringForFileStart()
	}

	// test
	func stringForMainStart() -> String {
		return dataSource.stringForMainStart()
	}

	func translateStatement(_ statement: JKRTreeStatement) -> String {
		switch statement {
		case let .assignment(assignment):
			return translateAssignment(assignment)
		case let .functionDeclaration(functionDeclaration):
			return translateFunctionDeclaration(functionDeclaration)
		case let .returnStm(returnStm):
			return translateReturn(returnStm)
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private func translateAssignment(_ assignment: JKRTreeAssignment)
		-> String
	{
		switch assignment {
		case let .declaration(type, id, expression):
			let typeText = translateType(type)
			let idText = translateID(id)
			let expressionText = translateExpression(expression)
			return "\(typeText)\(idText) = \(expressionText);\n"
		case let .assignment(id, expression):
			let idText = translateID(id)
			let expressionText = translateExpression(expression)
			return "\(idText) = \(expressionText);\n"
		}
	}

	private func translateFunctionDeclaration(
		_ functionDeclaration: JKRTreeFunctionDeclaration) -> String
	{
		return dataSource.stringForFunctionHeader(
			withType: functionDeclaration.type,
			id: functionDeclaration.id,
			parameters: functionDeclaration.parameters)
	}

	private func translateReturn(_ expression: JKRTreeExpression) -> String {
		let expression = translateExpression(expression)
		return "return \(expression);\n"
	}

	private func translateType(_ text: JKRTreeType) -> String {
		return dataSource.spacedStringForType(text)
	}

	private func translateID(_ text: JKRTreeID) -> String {
		return dataSource.stringForID(text)
	}

	private func translateExpression(_ expression: JKRTreeExpression)
		-> String
	{
		switch expression {
		case let .int(text):
			return dataSource.stringForInt(text)
		case let .parenthesized(innerExpression):
			let innerExpressionText = translateExpression(innerExpression)
			return "(\(innerExpressionText))"
		case let .operation(leftExpression, operatorText, rightExpression):
			let leftText = translateExpression(leftExpression)
			let rightText = translateExpression(rightExpression)
			return "\(leftText) \(operatorText) \(rightText)"
		case let .lvalue(text):
			return translateID(text)
		}
	}
}
