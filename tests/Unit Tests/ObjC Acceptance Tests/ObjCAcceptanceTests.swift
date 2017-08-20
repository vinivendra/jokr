import XCTest

private let testFilesPath = CommandLine.arguments[1] +
"/tests/Unit Tests/ObjC Acceptance Tests/"

private let outputDirectory = CommandLine.arguments[1] +
"/tests/Unit Tests/ObjC Acceptance Tests/Output/"

private let errorMessage =
"Transpiler failed during test.\nError: "

class ObjCAcceptanceTests: XCTestCase {
	let parser = JKRAntlrParser()

	func transpileAndRun(
		file filename: String) throws -> Shell.CommandResult {
		do {
			let program = try parser.parse(file: testFilesPath + filename)
			let writer = JKRFileWriter(outputDirectory: outputDirectory)
			let translator = JKRObjcTranslator(writingWith: writer)
			try translator.translate(program: program)
			let compiler = JKRObjcCompiler()
			try compiler.compileFiles(atPath: outputDirectory)
			return compiler.runProgram(atPath: outputDirectory)
		}
		catch (let error) {
			throw error
		}
	}

	func testEmpty() {
		do {
			let (output, status) = try transpileAndRun(file: "TestEmpty.jkr")
			XCTAssertEqual(status, 0)
			XCTAssertEqual(output, "")
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
