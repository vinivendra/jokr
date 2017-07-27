import Antlr4

// TODO: Fix the forced unwraps

extension JokrParser.FunctionDeclarationContext {
	func toJKRTreeFunctionDeclaration() -> JKRTreeFunctionDeclaration {
		if let functionHeader = self.functionDeclarationHeader(),
			let functionParameters = self.functionDeclarationParameters(),
			let parameterList = functionParameters.parameterDeclarationList()
		{
			let type = functionHeader.TYPE()!.getText()
			let id = functionHeader.ID()!.getText()
			let parameters = parameterList.toJKRTreeParameters()

			return JKRTreeFunctionDeclaration(type: type,
			                                  id: id,
			                                  parameters: parameters)
		} else {
			assertionFailure("Failed to transpile function declaration")
			return JKRTreeFunctionDeclaration(type: "", id: "", parameters: [])
		}
	}
}

extension JokrParser.ParameterDeclarationListContext {
	func toJKRTreeParameters() -> [JKRTreeParameter] {
		if let parameter = parameterDeclaration() {
			let parameter = JKRTreeParameter(type: parameter.TYPE()!.getText(),
			                                 id: parameter.ID()!.getText())

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
			let expression = self.expression()
		{
			let type = variableDeclaration.TYPE()!.getSymbol()!.getText()!
			let id = variableDeclaration.ID()!.getSymbol()!.getText()!
			let expression = expression.toJKRTreeExpression()
			return .declaration(type, id, expression)
		}
		else if let lvalue = self.lvalue(),
			let expression = self.expression()
		{
			let id = lvalue.ID()!.getSymbol()!.getText()!
			let expression = expression.toJKRTreeExpression()
			return .assignment(id, expression)
		}
		else
		{
			assertionFailure("Failed to transpile assignment")
			return .assignment("", .int(""))
		}
	}
}

extension JokrParser.ExpressionContext {
	func toJKRTreeExpression() -> JKRTreeExpression {
		if let int = self.INT()?.getText() {
			return .int(int)
		}
		else if self.LPAREN() != nil,
			let expression = self.expression(0) {
			return .parenthesized(expression.toJKRTreeExpression())
		}
		else if let operatorText = self.OPERATOR()?.getText(),
			let lhs = self.expression(0),
			let rhs = self.expression(1) {
			let lhsExp = lhs.toJKRTreeExpression()
			let rhsExp = rhs.toJKRTreeExpression()
			return .operation(lhsExp, operatorText, rhsExp)
		}
		else if let lvalue = self.lvalue() {
			return .lvalue(lvalue.ID()!.getText())
		}

		assertionFailure("Failed to transpile expression")
		return .int("")
	}
}

// MARK: -
class JKRListener: JokrBaseListener {

	let transpiler: JKRTranspiler

	var indentation = 0

	init(language: JKRLanguageDataSource,
	     writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.transpiler = JKRTranspiler(language: language)
		self.writer = writer
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Writing

	let writer: JKRWriter

	func write(_ string: String) {
		writer.write(string)
	}

	func changeFile(_ string: String) {
		writer.changeFile(string)
	}

	func addIntentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Antlr

	override func enterProgram(_ ctx: JokrParser.ProgramContext) {
		super.enterProgram(ctx)
		indentation = 0
		write(transpiler.stringForFileStart())
	}

	override func exitProgram(_ ctx: JokrParser.ProgramContext) {
		super.exitProgram(ctx)
		indentation = 0
	}

	override func exitAssignment(_ ctx: JokrParser.AssignmentContext) {
		super.exitAssignment(ctx)

		let assignment = ctx.toJKRTreeAssignment()

		addIntentation()
		write(transpiler.transpileAssignment(assignment))
	}

	override func enterFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.enterFunctionDeclaration(ctx)

		let functionDeclaration = ctx.toJKRTreeFunctionDeclaration()

		addIntentation()
		write(transpiler.transpileFunctionDeclaration(functionDeclaration)
			+ " {\n")
		indentation += 1
	}

	override func exitFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.exitFunctionDeclaration(ctx)
		indentation -= 1
		addIntentation()
		write("}\n")
	}

	override func exitReturnStatement(_ ctx: JokrParser.ReturnStatementContext)
	{
		super.exitReturnStatement(ctx)

		let expression = ctx.expression()!.toJKRTreeExpression()

		addIntentation()
		write(transpiler.transpileReturn(expression))
	}
}
