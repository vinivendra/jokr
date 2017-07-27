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
		addIntentation()
		write(transpiler.transpileAssignment(ctx))
	}

	override func enterFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.enterFunctionDeclaration(ctx)
		addIntentation()
		write(transpiler.transpileFunctionDeclaration(ctx) + " {\n")
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
		write(transpiler.transpileReturn(ctx))
	}
}
