import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/Java/"

private let outputDirectory = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/Java/Output/"

private let errorMessage =
	"Transpiler failed during test.\nError: "

class JavaAcceptanceTests: XCTestCase {
	let parser = JKRAntlrParser()

	func transpileAndRun(
		file filename: String) throws -> Shell.CommandResult {
		do {
			let program = try parser.parse(file: testFilesPath + filename)
			let writer = JKRFileWriter(outputDirectory: outputDirectory)
			let translator = JKRJavaTranslator(writingWith: writer)
			try translator.translate(program: program)
			let compiler = JKRJavaCompiler()
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
			XCTAssertEqual(result.output, "Hello jokr!\n1\n1 2\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testAssignments() {
		do {
			let result = try transpileAndRun(file: "TestAssignments.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "4 3\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testExpressions() {
		do {
			let result = try transpileAndRun(file: "TestExpressions.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "4\n0\n12\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
