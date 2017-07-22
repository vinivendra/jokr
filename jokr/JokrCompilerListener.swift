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

// MARK: -

class JokrCompilerListener: JokrBaseListener {

	////////////////////////////////////////////////////////////////////////////
	// MARK: JKRWriter
	let writer: JKRWriter

	init(writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.writer = writer
	}

	func write(_ string: String) {
		writer.write(string)
	}

	func changeFile(_ string: String) {
		writer.changeFile(string)
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Common transpilation code

	func transpileType(_ type: TerminalNode?) -> String {
		let token = type?.getSymbol()

		if let text = token?.getText() {
			let lowercased = text.lowercased()
			if Objc.valueTypes.contains(lowercased) {
				return stringForValueType(lowercased)
			} else {
				return stringForObjectType(text)
			}
		}

		assertionFailure("Failed to transpile type")
		return ""
	}

	func stringForValueType(_ string: String) -> String {
		return string + " "
	}

	func stringForObjectType(_ string: String) -> String {
		return string + " "
	}

	//
	func transpileID(_ id: TerminalNode?) -> String {
		if let text = id?.getSymbol()?.getText() {
			return text
		}

		assertionFailure("Failed to transpile id")
		return ""
	}

	//
	func transpileExpression(_ expression: JokrParser.ExpressionContext)
		-> String
	{
		if let int = expression.INT()?.getText() {
			return int
		} else if expression.LPAREN() != nil,
			let expression = expression.expression(0) {
			return "(\(transpileExpression(expression)))"
		} else if let operatorText = expression.OPERATOR()?.getText(),
			let lhs = expression.expression(0),
			let rhs = expression.expression(1) {
			let lhsText = transpileExpression(lhs)
			let rhsText = transpileExpression(rhs)
			return "\(lhsText) \(operatorText) \(rhsText)"
		} else if let lvalue = expression.lvalue() {
			return lvalue.ID()!.getSymbol()!.getText()!
		}

		assertionFailure("Failed to transpile expression")
		return ""
	}

	//
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
}
