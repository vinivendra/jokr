import Antlr4

extension JokrParser.ParameterDeclarationListContext {
	func parameters() -> [JokrParser.ParameterDeclarationContext] {
		if let parameter = parameterDeclaration() {
			if let parameterList = parameterDeclarationList() {
				return [parameter] + parameterList.parameters()
			} else {
				return [parameter]
			}
		} else {
			return []
		}
	}
}

class JokrCompilerListener: JokrBaseListener {
	let writer: JKRWriter

	init(writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.writer = writer
	}

	func write(_ string: String) {
		writer.write(string)
	}

	func changeFile(_ string: String) {
		writer.changeFile(string)
	}
}
