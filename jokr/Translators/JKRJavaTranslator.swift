// doc
// test
class JKRJavaTranslator: JKRTranslator {
	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	init(writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.writer = writer
	}

	static func create(writingWith writer: JKRWriter) -> JKRTranslator {
		return JKRJavaTranslator(writingWith: writer)
	}

	func translate(tree: JKRTree) throws {
		do {
			switch tree {
			case let .statements(statements):
				writeStatementsFile(withStatements: statements)
			case let .declarations(declarations):
				writeDeclarationsFile(withDeclarations: declarations)
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
		withStatements statements: ([JKRTreeStatement])) {

		changeFile("Main.java")

		write("public class Main {\n")
		indentation = 1

		writeIndentation()
		write("public static void main(String []args) {\n")
		indentation += 1

		writeWithStructure(statements)

		indentation = 1
		writeIndentation()
		write("}\n}\n")
	}

	private func writeDeclarationsFile(
		withDeclarations declarations: ([JKRTreeDeclaration])) {

		for case let .classDeclaration(classDeclaration)
			in declarations
		{
			let className = classDeclaration.type.text
			changeFile("\(className).java")

			write("public class \(className) {\n")
			indentation = 1

			writeWithStructure(classDeclaration.methods)

			write("}\n")
		}
	}

	private func writeWithStructure(_ statements: [JKRTreeStatement]) {
		for statement in statements {
			writeWithStructure(statement)
		}
	}

	private func writeWithStructure(_ statement: JKRTreeStatement) {
		writeIndentation()

		switch statement {
		case let .assignment(assignment):
			write(translate(assignment))
		case let .functionCall(functionCall):
			write(translate(functionCall))
		case let .returnStm(returnStm):
			write(translate(returnStm))
		}
	}

	private func writeWithStructure(_ methods: [JKRTreeFunctionDeclaration]) {
		// Write methods with newlines in between them
		for method in methods.dropLast() {
			writeWithStructure(method)
			write("\n")
		}
		if let lastMethod = methods.last {
			writeWithStructure(lastMethod)
		}
	}

	private func writeWithStructure(_ method: JKRTreeFunctionDeclaration) {
		writeIndentation()
		write(translateHeader(method))
		write(" {\n")

		if method.block.count > 0 {
			indentation += 1
			writeWithStructure(method.block)
			indentation -= 1
		}
		else {
			write("\n")
		}

		writeIndentation()
		write("}\n")
	}

	// Translation (pieces of code)
	private func translate(_ assignment: JKRTreeAssignment) -> String {
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
				return "System.out.format(\"Hello jokr!\\n\");\n"
			}
			else {
				let format = functionCall.parameters.map {_ in "%d" }
					.joined(separator: " ")
				let parameters = functionCall.parameters.map(translate)
					.joined(separator: ", ")
				return "System.out.format(\"\(format)\\n\", \(parameters));\n"
			}
		}

		return "\(string(for: functionCall.id))();\n"
	}

	private func translateHeader(
		_ function: JKRTreeFunctionDeclaration) -> String {

		let returnType = string(for: function.type)
		let functionName = string(for: function.id)
		let parameters = function.parameters.map(string(for:))
			.joined(separator: ", ")

		return "\(returnType) \(functionName)(\(parameters))"
	}

	private func translate(_ returnStm: JKRTreeReturn) -> String {
		let expression = translate(returnStm.expression)
		return "return \(expression);\n"
	}

	private func translate(_ expression: JKRTreeExpression) -> String {
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

	private func string(for parameter: JKRTreeParameterDeclaration) -> String {
		return "\(string(for: parameter.type)) \(string(for: parameter.id))"
	}

	private func string(for type: JKRTreeType,
	                    withSpaces: Bool = false) -> String {
		let lowercased = type.text.lowercased()

		let space = withSpaces ? " " : ""

		let result: String

		if JKRJavaTranslator.valueTypes.contains(lowercased) {
			result = lowercased
		}
		else {
			result = type.text
		}

		return result + space
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

	private func writeIndentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}
}
