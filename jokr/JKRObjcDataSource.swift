/// Stateless class to translate bits of code that are language specific (i.e.
/// are different in Objc and Java).
class JKRObjcDataSource: JKRLanguageDataSource {
	static let valueTypes = ["void", "int", "float"]

	func stringForFileStart() -> String {
		return "#import <Foundation/Foundation.h>\n\n"
	}

	func spacedStringForType(_ type: JKRTreeType) -> String {
		let lowercased = type.text.lowercased()

		if JKRObjcDataSource.valueTypes.contains(lowercased) {
			return lowercased + " "
		} else {
			return type.text + " *"
		}
	}

	func stringForType(_ type: JKRTreeType) -> String {
		let lowercased = type.text.lowercased()

		if JKRObjcDataSource.valueTypes.contains(lowercased) {
			return lowercased
		} else {
			return type.text + " *"
		}
	}

	func stringForFunctionHeader(
		withType type: JKRTreeType,
		id: JKRTreeID,
		parameters: [JKRTreeParameter]) -> String
	{
		var contents = "- (\(stringForType(type)))\(stringForID(id))"

		let parameters = parameters.map(stringsForParameter)

		if let parameter = parameters.first {
			contents += ":(\(parameter.type))\(parameter.id)"
		}

		for parameter in parameters.dropFirst() {
			contents += " \(parameter.id):(\(parameter.type))\(parameter.id)"
		}

		return contents
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: Private

	private func stringsForParameter(
		_ parameter: JKRTreeParameter) ->
		(type: String, id: String)
	{
		return (stringForType(parameter.type),
		        stringForID(parameter.id))
	}
}
