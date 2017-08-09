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

func log(_ string: String) {
	if jkrDebug {
		print(string)
	}
}

var jkrDebug: Bool = true

class JKRDriver {
	private let folderPath: String
	private let parser: JKRParser

	init(folderPath: String, parser: JKRParser) {
		self.folderPath = folderPath
		self.parser = parser
	}

	func parse(file: String) throws -> [JKRTreeStatement] {
		do {
			return try parser.parse(file: folderPath + file)
		}
		catch (let error) {
			throw error
		}
	}
}
