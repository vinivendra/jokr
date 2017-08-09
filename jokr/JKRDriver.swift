import Antlr4

enum JKRTargetLanguage {
	case java
	case objectiveC

	var translator: JKRTranslator.Type {
		switch self {
		case .java:
			return JKRJavaTranslator.self
		case .objectiveC:
			return JKRObjcTranslator.self
		}
	}

	var compiler: JKRCompiler.Type {
		switch self {
		case .java:
			return JKRJavaCompiler.self
		case .objectiveC:
			return JKRObjcCompiler.self
		}
	}
}

func log(_ string: String) {
	if jkrDebug {
		print(string)
	}
}

var jkrDebug: Bool = true

class JKRDriver {
	private let folderPath: String
	private let parser: JKRParser
	private let language: JKRTargetLanguage

	private var ast: [JKRTreeStatement]?

	init(folderPath: String,
	     parser: JKRParser,
	     language: JKRTargetLanguage) {
		self.folderPath = folderPath
		self.parser = parser
		self.language = language
	}

	func parseInputFiles() throws {
		do {
			ast = try parser.parse(file: folderPath + "main.jkr")
		}
		catch (let error) {
			throw error
		}
	}

	func writeOutputFiles() throws {
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

	func compile() {
		let compiler = language.compiler.create()
		compiler.compileFiles(atPath: folderPath)
	}

	func compileAndRun() {
		let compiler = language.compiler.create()
		let compileStatus = compiler.compileFiles(atPath: folderPath)
		if compileStatus == 0 {
			compiler.runProgram(atPath: folderPath)
		}
	}
}
