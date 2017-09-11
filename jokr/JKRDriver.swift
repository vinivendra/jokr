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

	@discardableResult
	func transpile() throws -> Shell.CommandResult {
		do {
			try parseInputFiles()
			try writeOutputFiles()
			return try compile()
		}
		catch (let error) {
			throw error
		}
	}

	@discardableResult
	func run() -> Shell.CommandResult {
		log("======== Running...")
		let compiler = language.compiler.create()
		let result = compiler.runProgram(atPath: folderPath)
		log(result.output)
		log("================")
		log(result.error)
		log("======== Done!...")
		return result
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Implementation

	private let folderPath: String
	private let parser: JKRParser
	private let language: JKRTargetLanguage

	private var ast: JKRTree?

	private func parseInputFiles() throws {
		do {
			log("======== Parsing...")
			ast = try parser.parse(file: folderPath + "main.jkr")
			log("======== Done!")
		}
		catch (let error) {
			log("======== Parsing failed.")
			throw error
		}
	}

	private func writeOutputFiles() throws {
		do {
			log("======== Transpiling files...")

			if ast == nil {
				try parseInputFiles()
			}

			let writer = JKRFileWriter(outputDirectory: folderPath)
			let translator = language.translator.create(writingWith: writer)

			try translator.translate(tree: ast!)
			// swiftlint:disable:previous force_unwrapping

			writer.prettyPrint()

			log("======== Done!")
		}
		catch (let error) {
			log("======== Transpilation failed.")
			throw error
		}
	}

	private func compile() throws -> Shell.CommandResult{
		do {
			log("======== Compiling...")
			let compiler = language.compiler.create()
			let result = try compiler.compileFiles(atPath: folderPath)
			log("======== Done!")
			return result
		}
		catch (let error) {
			log("======== Compilation failed.")
			throw error
		}
	}
}
