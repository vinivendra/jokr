import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/Kotlin/"

private let errorMessage =
	"Transpiler failed during test.\nError: "

class KotlinAcceptanceTests: XCTestCase {
	let parser = JKRAntlrParser()

	func transpileAndRun(test testName: String) throws -> Shell.CommandResult {
		let testFolder = testFilesPath + testName + "/"
		let testFile = testName + ".jkr"

		guard let tree = try parser.parse(
			file: testFolder + testFile) else
		{
			XCTFail("Failed to parse file \(testFile)")
			throw JKRError.parsing
		}

		let writer = JKRFileWriter(outputDirectory: testFolder)
		let translator = JKRKotlinTranslator(writingWith: writer)
		try translator.translate(tree: tree)
		let compiler = JKRKotlinCompiler()
		try compiler.compileFiles(atPath: testFolder)
		return compiler.runProgram(atPath: testFolder)
	}

	func trashTranslatedFilesAtTeardown(
        forTest testName: String,
        skipping filesToSkip: [String] = [])
    {
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
		trashTranslatedFilesAtTeardown(forTest: testName)

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "Hello jokr!\n1\n1 2\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testAssignments() {
		let testName = "TestAssignments"
		trashTranslatedFilesAtTeardown(forTest: testName)

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "4 3\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testExpressions() {
		let testName = "TestExpressions"
		trashTranslatedFilesAtTeardown(forTest: testName)

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "4\n0\n12\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testClasses() {
		let testName = "TestClasses"
		trashTranslatedFilesAtTeardown(forTest: testName,
                                       skipping: ["main.kt"])

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "5\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
