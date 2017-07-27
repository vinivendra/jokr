import Antlr4

// TODO: Consider sending braces into the transpiler.
// TODO: Consider creating a state machine between the listener and the 
// transpiler to handle indentation, scope, etc.

/// Antlr's CST visitor. Handles writing to the given target, manages 
/// indentation levels and opening/closing braces. Everything else is delegated
/// to the transpiler.
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

		let expression = ctx.getJKRTreeExpression()
		
		addIntentation()
		write(transpiler.transpileReturn(expression))
	}
}
