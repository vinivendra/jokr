import XCTest

private let testFilesPath = CommandLine.arguments[1] +
	"/tests/Acceptance Tests/Swift/"

private let errorMessage =
	"Transpiler failed during test.\nError: "

class SwiftAcceptanceTests: XCTestCase {
	let parser = JKRAntlrParser()

	func transpileAndRun(test testName: String, testFiles: [String]? = nil)
		throws -> Shell.CommandResult
	{
		let testFolder = testFilesPath + testName + "/"
		let testFiles = testFiles ?? [testName]

		for file in testFiles {
			let testFile = file + ".jkr"

			guard let tree = try parser.parse(
				file: testFolder + testFile) else
			{
				XCTFail("Failed to parse file \(testFile)")
				throw JKRError.parsing
			}

			let writer = JKRFileWriter(outputDirectory: testFolder)
			let translator = JKRSwiftTranslator(writingWith: writer)
			try translator.translate(tree: tree)
		}

		let compiler = JKRSwiftCompiler()
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
		trashTranslatedFilesAtTeardown(forTest: testName,
									   skipping: ["testExpressions.swift"])

		do {
			let result = try transpileAndRun(test: testName)
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output,
						   "4\n4\n4\n11\n7\n19\n9.0\n5\n5\n2\n3\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}

	func testClasses() {
		let testName = "TestClasses"
		trashTranslatedFilesAtTeardown(forTest: testName,
                                       skipping: ["main.jkr"])

		do {
			let result = try transpileAndRun(test: testName,
											 testFiles: ["main", "TestClasses"])
			XCTAssertEqual(result.status, 0)
			XCTAssertEqual(result.output, "5\n")
			XCTAssertEqual(result.error, (""))
		}
		catch (let error) {
			XCTFail(errorMessage + "\(error)")
		}
	}
}
