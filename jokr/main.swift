import Foundation
import Antlr4

private let filePath = CommandLine.arguments[1] + "/tests/"

do {
	print("Parsing...")
	let char = ANTLRInputStream(
		"Int x = 2\nInt y = x - x\nreturn 2\n")
	let lexer = JokrLexer(char)
	let tokens = CommonTokenStream(lexer)
	let parser = try JokrParser(tokens)
	parser.setBuildParseTree(true)
	let tree = try parser.program()

	let ast = tree.toJKRTreeStatements()
	let writer = JKRFileWriter(outputDirectory: filePath)
	let transpiler = JKRTranspiler(language: JKRObjcDataSource(),
	                               writingWith: writer)

	writer.changeFile("main")
	transpiler.transpileProgram(ast)
	try writer.finishWriting()

	let compiler = JKRObjcCompiler()
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
