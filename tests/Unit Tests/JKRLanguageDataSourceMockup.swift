import XCTest

class JKRLanguageDataSourceMockup: JKRLanguageDataSource {
	func stringForFileStart() -> String {
		return "File start\n"
	}

	func spacedStringForType(_ type: JKRTreeType) -> String {
		return type.text + " "
	}

	func stringForType(_ type: JKRTreeType) -> String {
		return type.text
	}

	func stringForFunctionHeader(
		withType type: JKRTreeType,
		id: JKRTreeID,
		parameters: [JKRTreeParameter]) -> String
	{
		return type.text + " " + id.text + "(" + parameters.description + ")"
	}
}
