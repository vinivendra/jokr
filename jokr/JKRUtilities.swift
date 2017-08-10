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

enum JKRError: Error {
	case compilation(CInt)
}

func log(_ string: String) {
	if jkrDebug {
		print(string)
	}
}

var jkrDebug: Bool = true
