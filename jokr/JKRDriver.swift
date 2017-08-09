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

	init(folderPath: String,
	     parser: JKRParser,
	     language: JKRTargetLanguage) {
		self.folderPath = folderPath
		self.parser = parser
		self.language = language
	}

	func parse(file: String) throws -> [JKRTreeStatement] {
		do {
			return try parser.parse(file: folderPath + file)
		}
		catch (let error) {
			throw error
		}
	}

	func translate(program: [JKRTreeStatement]) throws {
		do {
			let translator = language.translator.create(writingWith:
					JKRFileWriter(outputDirectory: folderPath))
			try translator.translate(program: program)
		}
		catch (let error) {
			throw error
		}
	}
}
