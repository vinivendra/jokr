import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/ObjC/"

private let errorMessage =
	"Transpiler failed during test.\nError: "

class ObjCAcceptanceTests: XCTestCase {
	let parser = JKRAntlrParser()

	func transpileAndRun(
		test testName: String) throws -> Shell.CommandResult {
		let testFolder = testFilesPath + testName + "/"
		let testFile = testName + ".jkr"

		guard let tree = try parser.parse(
			file: testFolder + testFile) else
		{
			XCTFail("Failed to parse file \(testFile)")
			throw JKRError.parsing
		}

		let writer = JKRFileWriter(outputDirectory: testFolder)
		let translator = JKRObjcTranslator(writingWith: writer)
		try translator.translate(tree: tree)
		let compiler = JKRObjcCompiler()
		try compiler.compileFiles(atPath: testFolder)
		return compiler.runProgram(atPath: testFolder)
	}

	func trashBuildFilesAtTeardown(forTest testName: String,
	                               skipping filesToSkip: [String] = []) {
		addTeardownBlock {
			do {
				try Files.trashFiles(
					atFolder: testFilesPath + testName + "/",
					skippingFiles: filesToSkip + [testName + ".jkr"])
			}
			catch (let error) {
				XCTFail("Failed to trash build files. Error: \(error)")
			}
		}
	}

	////////////////////////////////////////////////////////////////////////////
	// MARK: - Tests

	func testFunctionCalls() {
		let testName = "TestFunctionCalls"
		trashBuildFilesAtTeardown(forTest: testName)

		do {
			let result = try transpileAndRun(test: testName)
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
		let testName = "TestAssignments"
		trashBuildFilesAtTeardown(forTest: testName)

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.error.strippingNSLogData(), "4 3\n")
			XCTAssertEqual(result.output, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testExpressions() {
		let testName = "TestExpressions"
		trashBuildFilesAtTeardown(forTest: testName)

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.error.strippingNSLogData(), "4\n0\n12\n")
			XCTAssertEqual(result.output, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testClasses() {
		let testName = "TestClasses"
		trashBuildFilesAtTeardown(forTest: testName, skipping: ["main.m"])

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.error.strippingNSLogData(), "5\n")
			XCTAssertEqual(result.output, "")
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
