import Foundation
import Antlr4

// Branch - ClassDeclarations
// TODO: Refactor function declarations into class declarations (as methods)
// TODO: Add missing tests for declaration files, function declarations and
// returns
// TODO: Add method calls
// TODO: Add properties

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
