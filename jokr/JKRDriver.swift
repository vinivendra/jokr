import Antlr4

enum JKRTargetLanguage {
	case java
	case objectiveC

	var extensionName: String {
		switch self {
		case .java:
			return "java"
		case .objectiveC:
			return "m"
		}
	}
}

class JKRDriver {
	var debug: Bool
	var folderPath: String

	init(folderPath: String, debug: Bool = true) {
		self.folderPath = folderPath
		self.debug = debug
	}

	func log(_ string: String) {
		if debug {
			print(string)
		}
	}

	func parseFile(_ filename: String) throws -> JokrParser.ProgramContext {
		do {
			log("Parsing...")
			let contents = try String(contentsOfFile: folderPath + filename)
			let char = ANTLRInputStream(contents)
			let lexer = JokrLexer(char)
			let tokens = CommonTokenStream(lexer)
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()
			return tree
		}
		catch (let error) {
			throw error
		}
	}
}
