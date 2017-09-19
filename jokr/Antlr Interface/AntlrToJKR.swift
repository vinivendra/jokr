import Antlr4

/// Antlr extensions to convert the antlr concrete syntax tree to the jokr
/// abstract syntax tree. Makes the listener and transpiler codes lighter,
/// and contains potential antlr failures in one place.
///
/// Each function basically switches between its possible constructions in the
/// jokr grammar and then builds the corresponding jokr AST data structure.

extension TerminalNode {
	func toJKRTreeOperator() -> JKRTreeOperator {
		return JKRTreeOperator(getText())
	}

	func toJKRTreeID() -> JKRTreeID {
		return JKRTreeID(getText())
	}

	func toJKRTreeType() -> JKRTreeType {
		return JKRTreeType(getText())
	}

	func toJKRTreeInt() -> JKRTreeInt {
		guard let int = Int(getText()) else {
			fatalError(
				"Trying to create integer from invalid string: \(getText())")
		}

		return JKRTreeInt(int)
	}
}

extension JokrParser.ProgramContext {
	func toJKRTreeStatements() -> [JKRTreeStatement]? {
		if let statementList = statementList() {
			return statementList.toJKRTreeStatements()
		}
		else {
			return nil
		}
	}

	func toJKRTreeClasses() -> [JKRTreeClassDeclaration]? {
		if let declarationList = declarationList() {
			return declarationList.toJKRTreeClassDeclarations()
		}
		else {
			return nil
		}
	}
}

extension JokrParser.StatementListContext {
	func toJKRTreeStatements() -> [JKRTreeStatement] {
		guard let statement = statement()?.toJKRTreeStatement() else {
			fatalError("Failed to transpile statements")
		}

		if let statementList = statementList() {
			return statementList.toJKRTreeStatements() + [statement]
		}
		else {
			return [statement]
		}
	}
}

extension JokrParser.StatementContext {
	func toJKRTreeStatement() -> JKRTreeStatement {
		if let assignment = assignment() {
			return .assignment(assignment.toJKRTreeAssignment())
		}
		else if let functionCall = functionCall() {
			return .functionCall(functionCall.toJKRTreeFunctionCall())
		}
		else if let returnStatement = returnStatement() {
			return .returnStm(returnStatement.toJKRTreeReturn())
		}

		fatalError("Failed to transpile parameter")
	}
}

extension JokrParser.DeclarationListContext {
	func toJKRTreeClassDeclarations() -> [JKRTreeClassDeclaration] {
		guard let classDeclaration =
			classDeclaration()?.toJKRTreeClassDeclaration() else
		{
			fatalError("Failed to transpile declarations")
		}

		if let declarationList = declarationList() {
			return declarationList.toJKRTreeClassDeclarations() + [classDeclaration]
		}
		else {
			return [classDeclaration]
		}
	}
}

extension JokrParser.ExpressionContext {
	func toJKRTreeExpression() -> JKRTreeExpression {
		if let int = self.INT()?.toJKRTreeInt() {
			return .int(int)
		}
		else if self.LPAREN() != nil,
			let expression = self.expression(0)
		{
			return .parenthesized(expression.toJKRTreeExpression())
		}
		else if let op = self.OPERATOR()?.toJKRTreeOperator(),
			let lhs = self.expression(0),
			let rhs = self.expression(1)
		{
			let lhsExp = lhs.toJKRTreeExpression()
			let rhsExp = rhs.toJKRTreeExpression()
			return .operation(lhsExp, op, rhsExp)
		}
		else if let lvalue = self.lvalue(),
			let id = lvalue.ID()?.toJKRTreeID()
		{
			return .lvalue(id)
		}

		fatalError("Failed to transpile expression")
	}
}

extension JokrParser.ParameterListContext {
	func toJKRTreeExpressions() -> [JKRTreeExpression] {
		if let parameter = parameter() {

			guard let expression = parameter.expression()?.toJKRTreeExpression()
				else
			{
				fatalError("Failed to transpile parameter")
			}

			if let parameterList = parameterList() {
				return parameterList.toJKRTreeExpressions() + [expression]
			}
			else {
				return [expression]
			}
		}
		else {
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

		fatalError("Failed to transpile assignment")
	}
}

extension JokrParser.FunctionCallContext {
	func toJKRTreeFunctionCall() -> JKRTreeFunctionCall {
		if let id = self.ID()?.toJKRTreeID(),
			let parameters = self.parameterList()?.toJKRTreeExpressions()
		{
			return JKRTreeFunctionCall(id: id, parameters: parameters)
		}

		fatalError("Failed to transpile function call")
	}
}

extension JokrParser.ReturnStatementContext {
	func toJKRTreeReturn() -> JKRTreeReturn {
		if let expression = self.expression()?.toJKRTreeExpression() {
			return JKRTreeReturn(expression)
		}

		fatalError("Failed to transpile return")
	}
}

extension JokrParser.ParameterDeclarationListContext {
	func toJKRTreeParameterDeclarations() -> [JKRTreeParameterDeclaration] {
		if let parameter = parameterDeclaration() {

			guard let type = parameter.TYPE()?.toJKRTreeType(),
				let id = parameter.ID()?.toJKRTreeID() else
			{
				fatalError("Failed to transpile parameter")
			}

			let parameter = JKRTreeParameterDeclaration(type: type,
			                                 id: id)

			if let parameterList = parameterDeclarationList() {
				return parameterList.toJKRTreeParameterDeclarations() + [parameter]
			}
			else {
				return [parameter]
			}
		}
		else {
			return []
		}
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
			let parameters = parameterList.toJKRTreeParameterDeclarations()
			let block = statementList.toJKRTreeStatements()

			return JKRTreeFunctionDeclaration(type: type,
			                                  id: id,
			                                  parameters: parameters,
			                                  block: block)
		}

		fatalError("Failed to transpile function declaration")
	}
}

extension JokrParser.ClassMemberListContext {
	func toJKRTreeFunctionDeclarations() -> [JKRTreeFunctionDeclaration] {
		guard let functionDeclaration =
			classMember()?.toJKRTreeFunctionDeclaration() else {
			fatalError("Failed to transpile declarations")
		}

		if let classMemberList = classMemberList() {
			return classMemberList.toJKRTreeFunctionDeclarations() +
				[functionDeclaration]
		}
		else {
			return [functionDeclaration]
		}
	}
}

extension JokrParser.ClassMemberContext {
	func toJKRTreeFunctionDeclaration() -> JKRTreeFunctionDeclaration {
		if let functionDeclaration = functionDeclaration() {
			return functionDeclaration.toJKRTreeFunctionDeclaration()
		}

		fatalError("Failed to transpile parameter")
	}
}

extension JokrParser.ClassDeclarationContext {
	func toJKRTreeClassDeclaration() -> JKRTreeClassDeclaration {
		if let type = TYPE()?.toJKRTreeType() {
			if let functionDeclarations =
				classMemberList()?.toJKRTreeFunctionDeclarations() {
				return JKRTreeClassDeclaration(type: type,
				                               methods: functionDeclarations)
			}
			else {
				return JKRTreeClassDeclaration(type: type)
			}
		}

		fatalError("Failed to transpile class declaration")
	}
}
