import Foundation
import Antlr4

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
