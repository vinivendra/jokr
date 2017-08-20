import Foundation
import Antlr4

// Branch - acceptance tests
// TODO: Add function calls to add print statement to acceptance tests

// Branch - declarations
// TODO: Add class declarations
// TODO: Integrate class declarations to output file structure
// TODO: Add missing tests for declaration files, function declarations and
// returns

private let filePath = CommandLine.arguments[1] + "/tests/"

do {
	let driver = JKRDriver(folderPath: filePath,
	                       parser: JKRAntlrParser(),
	                       language: .objectiveC)

	try driver.transpile()
	driver.run()

	print("Done!")
}
catch (let error) {
	print("Failed :(")
	print(error)
}
