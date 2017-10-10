import Foundation
import Antlr4

// Branch - ClassDeclarations
// TODO: Add method calls
// TODO: Add properties

private let filePath = CommandLine.arguments[1] + "/example/"

do {
	let driver = JKRDriver(folderPath: filePath,
	                       parser: JKRAntlrParser(),
	                       language: .java)

	// TODO: Trash build files

	try driver.transpile()
	driver.run()
}
catch (let error) {
	log("Failed :(")
	log("\(error)")
}
