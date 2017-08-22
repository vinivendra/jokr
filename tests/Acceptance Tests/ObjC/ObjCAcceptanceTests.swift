import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/ObjC/"

private let outputDirectory = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/ObjC/Output/"

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
			let result = try transpileAndRun(file: "TestEmpty.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "")
			XCTAssertEqual(result.error, "")
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testFunctionCalls() {
		do {
			let result = try transpileAndRun(file: "TestFunctionCalls.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "")
			XCTAssert(result.error.hasSuffix("] Hello jokr!\n"))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
