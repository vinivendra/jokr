// doc
// test
class JKRJavaTranslator {
	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	init(writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.writer = writer
	}

	func transpileProgram(_ statements: [JKRTreeStatement]) {
		changeFile("Main.java")

		indentation = 0
		write("public class Main {\n")
		indentation += 1

		addIntentation()
		write("public static void main(String []args) {\n")
		indentation += 1

		writeWithStructure(statements)

		indentation = 1
		addIntentation()
		write("}\n}\n")
	}

	func endTranspilation() throws {
		do {
			try writer.finishWriting()
		}
		catch (let error) {
			throw error
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	static let valueTypes = ["int", "float", "void"]

	// Transpilation (general structure)
	private var indentation = 0

	private func writeWithStructure(_ statements: [JKRTreeStatement]) {
		for statement in statements {
			writeWithStructure(statement)
		}
	}

	private func writeWithStructure(_ statement: JKRTreeStatement) {
		addIntentation()
		write(translate(statement))

		if let block = statement.block {
			write(" {\n")
			indentation += 1
			writeWithStructure(block)
			indentation -= 1
			addIntentation()
			write("}\n")
		}
	}

	// Translation (pieces of code)
	private func translate(_ statement: JKRTreeStatement) -> String {
		switch statement {
		case let .assignment(assignment):
			return translate(assignment)
		case let .returnStm(returnStm):
			return translate(return: returnStm)
		case let .functionDeclaration(functionDeclaration):
			return translateHeader(functionDeclaration)
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

	private func translateHeader(
		_ function: JKRTreeFunctionDeclaration) -> String {
		let parameters = function.parameters.map(string(for:))
			.joined(separator: ", ")

		return "\(string(for: function.type)) \(string(for: function.id))(\(parameters))"
		// swiftlint:disable:previous line_length
	}

	private func translate(return expression: JKRTreeExpression) -> String {
		let expression = translate(expression)
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
		case let .operation(leftExpression, operatorText, rightExpression):
			let leftText = translate(leftExpression)
			let rightText = translate(rightExpression)
			return "\(leftText) \(operatorText) \(rightText)"
		case let .lvalue(id):
			return string(for: id)
		}
	}

	private func string(
		for parameter: JKRTreeParameter) -> String {
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

	func string(for int: String) -> String {
		return int
	}

	// Writing
	private let writer: JKRWriter

	private func write(_ string: String) {
		writer.write(string)
	}

	private func changeFile(_ string: String) {
		writer.changeFile(string)
	}

	private func addIntentation() {
		for _ in 0..<indentation {
			write("\t")
		}
	}
}
