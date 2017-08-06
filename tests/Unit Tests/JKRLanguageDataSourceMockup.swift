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
		var contents = type.text + " " + id.text + "("

		let parameters = parameters.map(stringsForParameter)

		if let parameter = parameters.first {
			contents += "\(parameter.type) \(parameter.id)"
		}

		for parameter in parameters.dropFirst() {
			contents += ", \(parameter.type) \(parameter.id)"
		}

		contents = contents + ")"

		return contents
	}

	private func stringsForParameter(
		_ parameter: JKRTreeParameter) ->
		(type: String, id: String)
	{
		return (stringForType(parameter.type),
		        stringForID(parameter.id))
	}
}
