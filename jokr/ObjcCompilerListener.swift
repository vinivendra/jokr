import Antlr4

enum Objc {
	static let valueTypes = ["void", "int", "float"]
}

class ObjcCompilerListener: JokrCompilerListener {
	var indentation = 0

	func addIntentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}

	override func stringForObjectType(_ string: String) -> String {
		return string + " *"
	}

	//
	override func enterProgram(_ ctx: JokrParser.ProgramContext) {
		super.enterProgram(ctx)

		write("#import <Foundation/Foundation.h>\n\n")
		indentation = 0
	}

	override func exitProgram(_ ctx: JokrParser.ProgramContext) {
		super.exitProgram(ctx)
		indentation = 0
	}

	override func exitAssignment(_ ctx: JokrParser.AssignmentContext) {
		super.exitAssignment(ctx)

		let assignmentText = transpileAssignment(ctx)

		addIntentation()
		write(assignmentText)
	}

	override func enterFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.enterFunctionDeclaration(ctx)

		let (type, id, parametersString) = unwrapFunctionDeclarationContext(ctx)

		if id == "main" {
			addIntentation()
			write("\(type)\(id)(\(parametersString)) {\n")
			indentation += 1

			addIntentation()
			write("@autoreleasepool {\n")
			indentation += 1
		} else {
			assertionFailure("Only 'main' function support for now")
		}
	}

	override func exitFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.exitFunctionDeclaration(ctx)

		indentation -= 1
		addIntentation()
		write("}\n")

		indentation -= 1
		addIntentation()
		write("}\n")
	}

	override func exitReturnStatement(_ ctx: JokrParser.ReturnStatementContext)
	{
		super.exitReturnStatement(ctx)

		let expression = transpileExpression(ctx.expression()!)

		addIntentation()
		write("return \(expression);\n")
	}
}
