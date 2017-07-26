import Antlr4

// TODO: Fix the forced unwraps

extension JokrParser.ParameterDeclarationListContext {
	func parameters() -> [JokrParser.ParameterDeclarationContext] {
		if let parameter = parameterDeclaration() {
			if let parameterList = parameterDeclarationList() {
				return parameterList.parameters() + [parameter]
			} else {
				return [parameter]
			}
		} else {
			return []
		}
	}
}

protocol LanguageDataSource {
	func stringForFileStart() -> String
	func spacedStringForType(_: String) -> String
	func stringForType(_: String) -> String
	func stringForID(_: String) -> String
	func stringForInt(_: String) -> String
	func stringForFunctionHeader(
		withType: String,
		id: String,
		parameters: [(type: String, id: String)]) -> String
}

extension LanguageDataSource {
	func stringForID(_ string: String) -> String {
		return string
	}

	func stringForInt(_ string: String) -> String {
		return string
	}
}

// MARK: -
class JokrTranspiler: JokrBaseListener {

	let dataSource: LanguageDataSource

	var indentation = 0

	init(language: LanguageDataSource,
	     writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.dataSource = language
		self.writer = writer
	}

	func addIntentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: JKRWriter

	let writer: JKRWriter

	func write(_ string: String) {
		writer.write(string)
	}

	func changeFile(_ string: String) {
		writer.changeFile(string)
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Transpilation

	func transpileType(_ type: TerminalNode?) -> String {
		if let text = type?.getSymbol()?.getText() {
			return dataSource.spacedStringForType(text)
		}

		assertionFailure("Failed to transpile type")
		return ""
	}

	//
	func transpileID(_ id: TerminalNode?) -> String {
		if let text = id?.getSymbol()?.getText() {
			return dataSource.stringForID(text)
		}

		assertionFailure("Failed to transpile id")
		return ""
	}

	//
	func transpileExpression(_ expression: JokrParser.ExpressionContext)
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

	//
	func transpileParameter(_ ctx: JokrParser.ParameterDeclarationContext) ->
		(type: String, id: String)
	{
		return (dataSource.stringForType(ctx.TYPE()!.getText()),
				dataSource.stringForID(ctx.ID()!.getText()))
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

	//
	func transpileFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext) -> String
	{
		let (type, id, parameters) = unwrapFunctionDeclarationContext(ctx)
		return dataSource.stringForFunctionHeader(
			withType: type,
			id: id,
			parameters: parameters)
	}

	func unwrapFunctionDeclarationContext(
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

	//
	func transpileReturn(_ ctx: JokrParser.ReturnStatementContext) -> String {
		let expression = transpileExpression(ctx.expression()!)
		return "return \(expression);\n"
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Antlr

	override func enterProgram(_ ctx: JokrParser.ProgramContext) {
		super.enterProgram(ctx)
		indentation = 0
		write(dataSource.stringForFileStart())
	}

	override func exitProgram(_ ctx: JokrParser.ProgramContext) {
		super.exitProgram(ctx)
		indentation = 0
	}

	override func exitAssignment(_ ctx: JokrParser.AssignmentContext) {
		super.exitAssignment(ctx)
		addIntentation()
		write(transpileAssignment(ctx))
	}

	override func enterFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.enterFunctionDeclaration(ctx)
		addIntentation()
		write(transpileFunctionDeclaration(ctx) + " {\n")
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
		addIntentation()
		write(transpileReturn(ctx))
	}
}
