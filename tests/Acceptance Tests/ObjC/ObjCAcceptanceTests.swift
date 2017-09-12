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
			guard let tree = try parser.parse(file: testFilesPath + filename)
				else
			{
				XCTFail("Failed to parse file \(filename)")
				throw JKRError.parsing
			}

			let writer = JKRFileWriter(outputDirectory: outputDirectory)
			let translator = JKRObjcTranslator(writingWith: writer)
			try translator.translate(tree: tree)
			let compiler = JKRObjcCompiler()
			try compiler.compileFiles(atPath: outputDirectory)
			return compiler.runProgram(atPath: outputDirectory)
		}
		catch (let error) {
			throw error
		}
	}

	func testFunctionCalls() {
		do {
			let result = try transpileAndRun(file: "TestFunctionCalls.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.error.strippingNSLogData(),
			               "Hello jokr!\n1\n1 2\n")
			XCTAssertEqual(result.output, "")
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testAssignments() {
		do {
			let result = try transpileAndRun(file: "TestAssignments.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.error.strippingNSLogData(), "4 3\n")
			XCTAssertEqual(result.output, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testExpressions() {
		do {
			let result = try transpileAndRun(file: "TestExpressions.jkr")
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.error.strippingNSLogData(), "4\n0\n12\n")
			XCTAssertEqual(result.output, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
