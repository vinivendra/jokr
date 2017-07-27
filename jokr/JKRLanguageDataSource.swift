protocol JKRLanguageDataSource {
	func stringForFileStart() -> String
	func spacedStringForType(_: String) -> String
	func stringForType(_: String) -> String
	func stringForID(_: String) -> String
	func stringForInt(_: String) -> String
	func stringForFunctionHeader(
		withType: String,
		id: String,
		parameters: [JKRTreeParameter]) -> String
}

extension JKRLanguageDataSource {
	func stringForID(_ string: String) -> String {
		return string
	}

	func stringForInt(_ string: String) -> String {
		return string
	}
}
