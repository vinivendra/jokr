import Foundation
import Antlr4

// Branch - acceptance tests
// TODO: Add parameters to function calls.

// Branch - declarations
// TODO: Add class declarations
// TODO: Integrate class declarations to output file structure
// TODO: Add missing tests for declaration files, function declarations and
// returns

private let filePath = CommandLine.arguments[1] + "/tests/"

do {
	let driver = JKRDriver(folderPath: filePath,
	                       parser: JKRAntlrParser(),
	                       language: .java)

	try driver.transpile()
	let result = driver.run()
}
catch (let error) {
	log("Failed :(")
	log(String(describing: error))
}
