import Antlr4

class Objc: LanguageDataSource {
	static let valueTypes = ["void", "int", "float"]

	func stringForFileStart() -> String {
		return "#import <Foundation/Foundation.h>\n\n"
	}

	func spacedStringForType(_ type: String) -> String {
		let lowercased = type.lowercased()

		if Objc.valueTypes.contains(lowercased) {
			return lowercased + " "
		} else {
			return type + " *"
		}
	}

	func stringForType(_ type: String) -> String {
		let lowercased = type.lowercased()

		if Objc.valueTypes.contains(lowercased) {
			return lowercased
		} else {
			return type + " *"
		}
	}

	func stringForFunctionHeader(
		withType type: String,
		id: String,
		parameters: [(type: String, id: String)]) -> String
	{
		var contents = "- (\(type))\(id)"

		if let parameter = parameters.first {
			contents += ":(\(parameter.type))\(parameter.id)"
		}

		for parameter in parameters.dropFirst() {
			contents += " \(parameter.id):(\(parameter.type))\(parameter.id)"
		}

		return contents
	}
}
