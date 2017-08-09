import Foundation
import Antlr4

// TODO: Fix filenames and extensions
// TODO: Join language classes into a single option
// TODO: Join antlr, transpiler and compiler into a single API

private let filePath = CommandLine.arguments[1] + "/tests/"

do {

	let driver = JKRDriver(folderPath: filePath,
	                       parser: JKRAntlrParser(),
	                       language: .objectiveC)

	try driver.parseInputFiles()
	try driver.writeOutputFiles()
	driver.compileAndRun()

	print("Done!")
}
catch (let error) {
	print("Failed :(")
	print(error)
}
