import Foundation
import Antlr4

// TODO: Add tests for Java translator and ObjC translator
// TODO: Add integration/acceptance tests for Java and ObjC

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
