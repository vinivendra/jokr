// doc
// test
class JKRObjcTranslator: JKRTranslator {
	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	init(writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.writer = writer
	}

	static func create(writingWith writer: JKRWriter) -> JKRTranslator {
		return JKRObjcTranslator(writingWith: writer)
	}

	func translate(tree: JKRTree) throws {
		do {
			switch tree {
			case let .statements(statements):
				writeStatementsFile(withStatements: statements)
			case let .declarations(declarations):
				writeDeclarationFiles(withDeclarations: declarations)
			}

			try writer.finishWriting()
		}
		catch (let error) {
			throw error
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private static let valueTypes = ["int", "float", "void"]

	// Transpilation (general structure)
	private var indentation = 0

	private func writeStatementsFile(
		withStatements statements: [JKRTreeStatement]) {

		changeFile("main.m")

		indentation = 0
		write("""
			#import <Foundation/Foundation.h>

			int main(int argc, const char * argv[]) {\n
			""")

		indentation += 1

		writeIntentation()
		write("@autoreleasepool {\n")
		indentation += 1

		writeWithStructure(statements)

		indentation = 1
		writeIntentation()
		write("}\n")
		writeIntentation()
		write("return 0;\n}\n")
	}

	private func writeDeclarationFiles(
		withDeclarations declarations: [JKRTreeDeclaration]) {

		for case let .classDeclaration(classDeclaration)
			in declarations
		{
			let className = classDeclaration.type.text

			// Interface file
			changeFile("\(className).h")

			write("""
				#import <Foundation/Foundation.h>

				@interface \(className) : NSObject

				@end\n
				""")
			indentation = 0
//			writeWithStructure(statements)
			write("}\n")

			// Implementation file
			changeFile("\(className).m")

			write("""
				#import \"\(className).h\"

				@implementation \(className)

				@end\n
				""")
			indentation = 0
//			writeWithStructure(statements)
			write("}\n")
		}
	}

	private func writeWithStructure(_ statements: [JKRTreeStatement]) {
		for statement in statements {
			writeWithStructure(statement)
		}
	}

	private func writeWithStructure(_ statement: JKRTreeStatement) {
		writeIntentation()
		write(translate(statement))

		//		if let block = statement.block {
		//			write(" {\n")
		//			indentation += 1
		//			writeWithStructure(block)
		//			indentation -= 1
		//			addIntentation()
		//			write("}\n")
		//		}
	}

	// Translation (pieces of code)
	private func translate(_ statement: JKRTreeStatement) -> String {
		switch statement {
		case let .assignment(assignment):
			return translate(assignment)
		case let .functionCall(functionCall):
			return translate(functionCall)
		case let .returnStm(returnStm):
			return translate(returnStm)
		}
	}

	private func translate(
		_ assignment: JKRTreeAssignment) -> String {
		switch assignment {
		case let .declaration(type, id, expression):
			let typeText = string(for: type, withSpaces: true)
			let idText = string(for: id)
			let expressionText = translate(expression)
			return "\(typeText)\(idText) = \(expressionText);\n"
		case let .assignment(id, expression):
			let idText = string(for: id)
			let expressionText = translate(expression)
			return "\(idText) = \(expressionText);\n"
		}
	}

	private func translate(_ functionCall: JKRTreeFunctionCall) -> String {
		if functionCall.id == "print" {
			if functionCall.parameters.count == 0 {
				return "NSLog(@\"Hello jokr!\\n\");\n"
			}
			else {
				let format = functionCall.parameters.map {_ in "%d" }
					.joined(separator: " ")
				let parameters = functionCall.parameters.map(translate)
					.joined(separator: ", ")
				return "NSLog(@\"\(format)\\n\", \(parameters));\n"
			}
		}

		return "\(string(for: functionCall.id))();\n"
	}

	private func translateHeader(
		_ function: JKRTreeFunctionDeclaration) -> String {
		var contents =
		"- (\(string(for: function.type)))\(string(for: function.id))"

		let parameters = function.parameters.map(strings(for:))

		if let parameter = parameters.first {
			contents += ":(\(parameter.type))\(parameter.id)"
		}

		for parameter in parameters.dropFirst() {
			contents += " \(parameter.id):(\(parameter.type))\(parameter.id)"
		}

		return contents
	}

	private func translate(_ returnStm: JKRTreeReturn) -> String {
		let expression = translate(returnStm.expression)
		return "return \(expression);\n"
	}

	private func translate(
		_ expression: JKRTreeExpression) -> String {
		switch expression {
		case let .int(int):
			return string(for: int)
		case let .parenthesized(innerExpression):
			let innerExpressionText = translate(innerExpression)
			return "(\(innerExpressionText))"
		case let .operation(leftExpression, op, rightExpression):
			let leftText = translate(leftExpression)
			let rightText = translate(rightExpression)
			return "\(leftText) \(op.text) \(rightText)"
		case let .lvalue(id):
			return string(for: id)
		}
	}

	private func strings(
		for parameter: JKRTreeParameterDeclaration)
		-> (type: String, id: String)
	{
		return (string(for: parameter.type),
		        string(for: parameter.id))
	}

	private func string(for type: JKRTreeType,
	                    withSpaces: Bool = false) -> String {
		let lowercased = type.text.lowercased()

		if JKRObjcTranslator.valueTypes.contains(lowercased) {
			if withSpaces {
				return lowercased + " "
			}
			else {
				return lowercased
			}
		}
		else {
			return type.text + " *"
		}
	}

	func string(for id: JKRTreeID) -> String {
		return id.text
	}

	func string(for int: JKRTreeInt) -> String {
		return String(int.value)
	}

	// Writing
	private let writer: JKRWriter

	private func write(_ string: String) {
		writer.write(string)
	}

	private func changeFile(_ string: String) {
		writer.changeFile(string)
	}

	private func writeIntentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}
}
