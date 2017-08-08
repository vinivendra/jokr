/// Stateless class to translate bits of code that are language specific (i.e.
/// are different in Objc and Java).
// doc
// test
class JKRJavaDataSource: JKRLanguageDataSource {
	static let valueTypes = ["void", "int", "float"]

	func stringForFileStart() -> String {
		return ""
	}

	// test
	func stringForMainStart() -> String {
		return "public class Main {\n\tpublic static void main(String[] args) {\n\t\tSystem.out.println(\"helloooow\");\n"
		// swiftlint:disable:previous line_length
	}

	func spacedStringForType(_ type: JKRTreeType) -> String {
		let lowercased = type.text.lowercased()

		if JKRObjcDataSource.valueTypes.contains(lowercased) {
			return lowercased + " "
		}
		else {
			return type.text + " "
		}
	}

	func stringForType(_ type: JKRTreeType) -> String {
		let lowercased = type.text.lowercased()

		if JKRObjcDataSource.valueTypes.contains(lowercased) {
			return lowercased
		}
		else {
			return type.text
		}
	}

	func stringForFunctionHeader(
		withType type: JKRTreeType,
		id: JKRTreeID,
		parameters: [JKRTreeParameter]) -> String
	{
		let parameters = parameters.map(stringsForParameter)
			.map { "\($0.type) \($0.id)" }
			.joined(separator: ", ")

		return "\(stringForType(type)) \(stringForID(id))(\(parameters)) {\n"
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
