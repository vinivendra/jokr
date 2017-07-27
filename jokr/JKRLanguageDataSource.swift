protocol JKRLanguageDataSource {
	func stringForFileStart() -> String
	func spacedStringForType(_: JKRTreeType) -> String
	func stringForType(_: JKRTreeType) -> String
	func stringForID(_: JKRTreeID) -> String
	func stringForInt(_: String) -> String
	func stringForFunctionHeader(
		withType: JKRTreeType,
		id: JKRTreeID,
		parameters: [JKRTreeParameter]) -> String
}

extension JKRLanguageDataSource {
	func stringForID(_ string: JKRTreeID) -> String {
		return string.text
	}

	func stringForInt(_ string: String) -> String {
		return string
	}
}
