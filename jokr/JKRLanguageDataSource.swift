/// Interface for the Objc and Java language data sources. Anything the
/// transpiler needs from them should be used through this protocol.
protocol JKRLanguageDataSource {
	func stringForFileStart() -> String
	func stringForMainStart() -> String

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
