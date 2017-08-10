import Antlr4

class JKRDriver {
	////////////////////////////////////////////////////////////////////////////
	// MARK: Interface

	init(folderPath: String,
	     parser: JKRParser,
	     language: JKRTargetLanguage) {
		self.folderPath = folderPath
		self.parser = parser
		self.language = language
	}

	func translate() throws {
		do {
			try parseInputFiles()
			try writeOutputFiles()
		}
		catch (let error) {
			throw error
		}
	}

	func transpile() throws {
		do {
			try parseInputFiles()
			try writeOutputFiles()
			try compile()
		}
		catch (let error) {
			throw error
		}
	}

	func run() {
		let compiler = language.compiler.create()
		compiler.runProgram(atPath: folderPath)
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private let folderPath: String
	private let parser: JKRParser
	private let language: JKRTargetLanguage

	private var ast: JKRTreeProgram?

	private func parseInputFiles() throws {
		do {
			ast = try parser.parse(file: folderPath + "main.jkr")
		}
		catch (let error) {
			throw error
		}
	}

	private func writeOutputFiles() throws {
		do {
			if ast == nil {
				try parseInputFiles()
			}

			let translator = language.translator.create(writingWith:
					JKRFileWriter(outputDirectory: folderPath))

			try translator.translate(program: ast!)
			// swiftlint:disable:previous force_unwrapping
		}
		catch (let error) {
			throw error
		}
	}

	private func compile() throws {
		do {
			let compiler = language.compiler.create()
			try compiler.compileFiles(atPath: folderPath)
		}
		catch (let error) {
			throw error
		}
	}
}
