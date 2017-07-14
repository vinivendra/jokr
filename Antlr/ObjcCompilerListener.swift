import Antlr4

enum Objc {
	static let valueTypes = ["int", "float"]
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
	var contents = ""

	var indentation = 0

	func addIntentation() {
		for _ in 0..<indentation {
			contents += "\t"
		}
	}

	override func enterProgram(_ ctx: JokrParser.ProgramContext) {
		super.enterProgram(ctx)

		contents += "#import <Foundation/Foundation.h>\n\nint main(int argc, const char * argv[]) {\n\t@autoreleasepool {\n"
		indentation = 2
	}

	override func exitProgram(_ ctx: JokrParser.ProgramContext) {
		super.exitProgram(ctx)

		contents += "\t}\n\treturn 0;\n}\n"
		indentation = 0
	}

	override func exitAssignment(_ ctx: JokrParser.AssignmentContext) {
		super.exitAssignment(ctx)

		if let variableDeclaration = ctx.variableDeclaration(),
			let expression = ctx.expression(),
			let type = variableDeclaration.TYPE()?.getSymbol()?.typeToObjc,
			let id = variableDeclaration.ID()?.getSymbol()?.getText() {

			addIntentation()
			contents += "\(type)\(id) = \(expression.toObjc);\n"
		} else if let lvalue = ctx.lvalue(),
			let expression = ctx.expression(),
			let id = lvalue.ID()?.getSymbol()?.getText() {

			addIntentation()
			contents += "\(id) = \(expression.toObjc);\n"
		} else {
			assertionFailure("Failed to transpile assignment")
		}
	}
}
