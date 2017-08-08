import Foundation
import Antlr4

// TODO: Fix filenames and extensions
// TODO: Join language classes into a single option
// TODO: Join antlr, transpiler and compiler into a single API

private let filePath = CommandLine.arguments[1] + "/tests/"

do {

	let driver = JKRDriver(folderPath: filePath)

	let tree = try driver.parseFile("main.jkr")

	let ast = tree.toJKRTreeStatements()
	let transpiler = JKRTranspiler(
		language: JKRJavaDataSource(),
		writingWith: JKRFileWriter(outputDirectory: filePath,
		                           fileExtension: "java"))

	transpiler.changeFile("Main")
	transpiler.transpileProgram(ast)
	try transpiler.endTranspilation()

	let compiler = JKRJavaCompiler()
	let compileStatus = compiler.compileFiles(atPath: filePath)
	if compileStatus == 0 {
		compiler.runProgram(atPath: filePath)
	}

	print("Done!")
}
catch (let error) {
	print("Failed :(")
	print(error)
}
