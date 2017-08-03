import Antlr4

/// Antlr extensions to convert the antlr concrete syntax tree to the jokr
/// abstract syntax tree. Makes the listener and transpiler codes lighter,
/// and contains potential antlr failures in one place.
///
/// Each function basically switches between its possible constructions in the
/// jokr grammar and then builds the corresponding jokr AST data structure.

extension TerminalNode {
	func toJKRTreeID() -> JKRTreeID {
		return JKRTreeID(getText())
	}

	func toJKRTreeType() -> JKRTreeType {
		return JKRTreeType(getText())
	}
}

extension JokrParser.ProgramContext {
	func toJKRTreeStatements() -> [JKRTreeStatement] {
		if let statementList = statementList() {
			return statementList.toJKRTreeStatements()
		} else {
			return []
		}
	}
}

extension JokrParser.StatementListContext {
	func toJKRTreeStatements() -> [JKRTreeStatement] {
		guard let statement = statement()?.toJKRTreeStatement() else {
			assertionFailure("Failed to transpile parameter")
			return []
		}

		if let statementList = statementList() {
			return statementList.toJKRTreeStatements() + [statement]
		} else {
			return [statement]
		}
	}
}

extension JokrParser.StatementContext {
	func toJKRTreeStatement() -> JKRTreeStatement {
		if let assignment = assignment() {
			return .assignment(assignment.toJKRTreeAssignment())
		} else if let functionDeclaration = functionDeclaration() {
			return .functionDeclaration(
				functionDeclaration.toJKRTreeFunctionDeclaration())
		} else if let returnStatement = returnStatement() {
			return .returnStm(returnStatement.getJKRTreeExpression())
		}

		assertionFailure("Failed to transpile parameter")
		return .returnStm(JKRTreeExpression.int(""))
	}
}

extension JokrParser.FunctionDeclarationContext {
	func toJKRTreeFunctionDeclaration() -> JKRTreeFunctionDeclaration {
		if let functionHeader = self.functionDeclarationHeader(),
			let functionParameters = self.functionDeclarationParameters(),
			let parameterList = functionParameters.parameterDeclarationList(),
			let type = functionHeader.TYPE()?.toJKRTreeType(),
			let id = functionHeader.ID()?.toJKRTreeID(),
			let statementList = block()?.statementList()
		{
			let parameters = parameterList.toJKRTreeParameters()
			let block = statementList.toJKRTreeStatements()

			return JKRTreeFunctionDeclaration(type: type,
			                                  id: id,
			                                  parameters: parameters,
			                                  block: block)
		}

		assertionFailure("Failed to transpile function declaration")
		return JKRTreeFunctionDeclaration(type: JKRTreeType(""),
		                                  id: JKRTreeID(""),
		                                  parameters: [],
		                                  block: [])
	}
}

extension JokrParser.ParameterDeclarationListContext {
	func toJKRTreeParameters() -> [JKRTreeParameter] {
		if let parameter = parameterDeclaration() {

			guard let type = parameter.TYPE()?.toJKRTreeType(),
				let id = parameter.ID()?.toJKRTreeID() else
			{
				assertionFailure("Failed to transpile parameter")
				return []
			}

			let parameter = JKRTreeParameter(type: type,
			                                 id: id)

			if let parameterList = parameterDeclarationList() {
				return parameterList.toJKRTreeParameters() + [parameter]
			} else {
				return [parameter]
			}
		} else {
			return []
		}
	}
}

extension JokrParser.AssignmentContext {
	func toJKRTreeAssignment() -> JKRTreeAssignment {
		if let variableDeclaration = self.variableDeclaration(),
			let expression = self.expression(),
			let type = variableDeclaration.TYPE()?.toJKRTreeType(),
			let id = variableDeclaration.ID()?.toJKRTreeID()
		{
			let expression = expression.toJKRTreeExpression()
			return .declaration(type, id, expression)
		}
		else if let lvalue = self.lvalue(),
			let expression = self.expression(),
			let id = lvalue.ID()?.toJKRTreeID()
		{
			let expression = expression.toJKRTreeExpression()
			return .assignment(id, expression)
		}

		assertionFailure("Failed to transpile assignment")
		return .assignment(JKRTreeID(""), .int(""))
	}
}

extension JokrParser.ExpressionContext {
	func toJKRTreeExpression() -> JKRTreeExpression {
		if let int = self.INT()?.getText() {
			return .int(int)
		}
		else if self.LPAREN() != nil,
			let expression = self.expression(0)
		{
			return .parenthesized(expression.toJKRTreeExpression())
		}
		else if let operatorText = self.OPERATOR()?.getText(),
			let lhs = self.expression(0),
			let rhs = self.expression(1)
		{
			let lhsExp = lhs.toJKRTreeExpression()
			let rhsExp = rhs.toJKRTreeExpression()
			return .operation(lhsExp, operatorText, rhsExp)
		}
		else if let lvalue = self.lvalue(),
			let id = lvalue.ID()?.toJKRTreeID()
		{
			return .lvalue(id)
		}

		assertionFailure("Failed to transpile expression")
		return .int("")
	}
}

extension JokrParser.ReturnStatementContext {
	func getJKRTreeExpression() -> JKRTreeExpression {
		if let expression = self.expression()?.toJKRTreeExpression() {
			return expression
		}

		assertionFailure("Failed to transpile return")
		return .int("")
	}
}
