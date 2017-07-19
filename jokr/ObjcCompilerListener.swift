import Antlr4

enum Objc {
	static let valueTypes = ["void", "int", "float"]
}

private extension Token {
	var typeToObjc: String {
		if let text = self.getText() {
			let lowercased = text.lowercased()
			if Objc.valueTypes.contains(lowercased) {
				return lowercased + " "
			} else {
				return text + " *"
			}
		}

		assertionFailure("Failed to transpile type")
		return "" // never reached
	}
}

private extension JokrParser.LvalueContext {
	var toObjc: String {
		if let id = self.ID()?.getText() {
			return id
		}

		assertionFailure("Failed to transpile lvalue")
		return "" // never reached
	}
}

private extension JokrParser.ExpressionContext {
	var toObjc: String {
		if let int = self.INT()?.getText() {
			return int
		} else if self.LPAREN() != nil,
			let expression = self.expression(0) {
			return "(\(expression.toObjc))"
		} else if let operatorText = self.OPERATOR()?.getText(),
			let lhs = expression(0),
			let rhs = expression(1) {
			return "\(lhs.toObjc) \(operatorText) \(rhs.toObjc)"
		} else if let lvalue = lvalue() {
			return lvalue.toObjc
		}

		assertionFailure("Failed to transpile expression")
		return "" // never reached
	}
}

class ObjcCompilerListener: JokrCompilerListener {
	var indentation = 0

	func addIntentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}

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

		if let variableDeclaration = ctx.variableDeclaration(),
			let expression = ctx.expression(),
			let type = variableDeclaration.TYPE()?.getSymbol()?.typeToObjc,
			let id = variableDeclaration.ID()?.getSymbol()?.getText() {

			addIntentation()
			write("\(type)\(id) = \(expression.toObjc);\n")
		} else if let lvalue = ctx.lvalue(),
			let expression = ctx.expression(),
			let id = lvalue.ID()?.getSymbol()?.getText() {

			addIntentation()
			write("\(id) = \(expression.toObjc);\n")
		} else {
			assertionFailure("Failed to transpile assignment")
		}
	}

	override func enterFunctionDeclaration(
		_ ctx: JokrParser.FunctionDeclarationContext)
	{
		super.enterFunctionDeclaration(ctx)

		if let functionHeader = ctx.functionDeclarationHeader(),
			let functionParameters = ctx.functionDeclarationParameters(),
			let parameterList = functionParameters.parameterDeclarationList(),
			let type = functionHeader.TYPE()?.getSymbol()?.typeToObjc,
			let id = functionHeader.ID()?.getSymbol()?.getText()
			{
				let parameters = parameterList.parameters()
				let parametersString = parameters.map {
					$0.TYPE()!.getSymbol()!.typeToObjc +
						$0.ID()!.getSymbol()!.getText()!
				}.joined(separator: ", ")

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
		} else {
			assertionFailure("Failed to transpile function declaration")
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

		let expression = ctx.expression()!.toObjc

		addIntentation()
		write("return \(expression);\n")
	}
}
