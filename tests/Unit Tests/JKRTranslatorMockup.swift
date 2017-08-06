class JKRTranslatorMockup: JKRTranslator {
	init() {
		super.init(language: JKRLanguageDataSourceMockup())
	}

	// Private because it shouldn't be called
	private override init(language: JKRLanguageDataSource) {
		super.init(language: JKRLanguageDataSourceMockup())
	}

	override func stringForFileStart() -> String {
		return "Translator file start\n"
	}

	override func translateStatement(_ statement: JKRTreeStatement) -> String {
		switch statement {
		case .assignment:
			return "Translator assignment\n"
		case .functionDeclaration:
			return "Translator function declaration"
		case .returnStm:
			return "Translator return statement\n"
		}
	}
}
