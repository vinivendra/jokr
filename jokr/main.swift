import Foundation
import Antlr4

private let filePath = CommandLine.arguments[1] + "/tests/"

do {
	print("Parsing...")
	let char = ANTLRInputStream(
		"Int x = 2\nInt y = x - x\n")
	let lexer = JokrLexer(char)
	let tokens = CommonTokenStream(lexer)
	let parser = try JokrParser(tokens)
	parser.setBuildParseTree(true)
	let tree = try parser.program()

	let ast = tree.toJKRTreeStatements()
	let writer = JKRFileWriter(outputDirectory: filePath, fileExtension: "java")
	let transpiler = JKRTranspiler(language: JKRJavaDataSource(),
	                               writingWith: writer)

	writer.changeFile("Main")
	transpiler.transpileProgram(ast)
	try writer.finishWriting()

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
