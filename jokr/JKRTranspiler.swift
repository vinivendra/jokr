/// Class that implements the transpilation algorithm's general structure.
/// Translating individual bits of code is delegated to the `translator`; the
/// code's structure, indentation, opening and closing of braces, scopes, etc.
/// are handled here.
class JKRTranspiler {
	let translator: JKRTranslator
	let writer: JKRWriter
	var indentation = 0

	init(language: JKRLanguageDataSource,
	     writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.translator = JKRTranslator(language: language)
		self.writer = writer
	}

	/// Mostly for initializing with a mockup translator when running unit tests
	init(translator: JKRTranslator,
	     writingWith writer: JKRWriter = JKRConsoleWriter()) {
		self.translator = translator
		self.writer = writer
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	func transpileProgram(_ statements: [JKRTreeStatement]) {
		// test
		if writer.currentFileName == "main" {
			write(translator.stringForMainStart())
			indentation += 2

			transpileStatements(statements)

			indentation = 1
			addIntentation()
			write("}\n}\n")
		}
		else {
			write(translator.stringForFileStart())

			transpileStatements(statements)
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private func transpileStatements(_ statements: [JKRTreeStatement]) {
		for statement in statements {
			transpileStatement(statement)
		}
	}

	private func transpileStatement(_ statement: JKRTreeStatement) {
		addIntentation()
		write(translator.translateStatement(statement))

		if let block = statement.block {
			write(" {\n")
			indentation += 1
			transpileStatements(block)
			indentation -= 1
			addIntentation()
			write("}\n")
		}
	}

	// Writing
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
