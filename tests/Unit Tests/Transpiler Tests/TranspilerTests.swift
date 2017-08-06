import XCTest

class TranspilerTests: XCTestCase {
	func testSimpleStatements() {
		let writer = JKRStringWriter()
		let transpiler = JKRTranspiler(translator: JKRTranslatorMockup(),
		                               writingWith: writer)
		let ast: [JKRTreeStatement] = [
			.assignment(.declaration("Int", "y", .int("0"))),
			.returnStm(.int("1"))
		]

		writer.changeFile("main")
		transpiler.transpileProgram(ast)

		XCTAssertEqual(writer.files["main"],
		               "Translator file start\nTranslator assignment\nTranslator return statement\n")
		// swiftlint:disable:previous line_length
	}

	func testFunctionDeclaration() {
		let writer = JKRStringWriter()
		let transpiler = JKRTranspiler(translator: JKRTranslatorMockup(),
		                               writingWith: writer)
		let ast: [JKRTreeStatement] = [
			.functionDeclaration(
				JKRTreeFunctionDeclaration(
					type: "Int", id: "foo",
					parameters: [],
					block: [
						.assignment(.declaration("Int", "x", .int("0"))),
						.returnStm(.int("0"))]))
		]

		writer.changeFile("main")
		transpiler.transpileProgram(ast)

		XCTAssertEqual(writer.files["main"],
		               "Translator file start\nTranslator function declaration {\n\tTranslator assignment\n\tTranslator return statement\n}\n")
		// swiftlint:disable:previous line_length
	}
}
