import Foundation
import Antlr4

private let filePath = CommandLine.arguments[1] + "/tests/"

do {
	print("Parsing...")
	let char = ANTLRInputStream(
		"Int x = 2\nInt y = x - x\nreturn y\n")
	let lexer = JokrLexer(char)
	let tokens = CommonTokenStream(lexer)
	let parser = try JokrParser(tokens)
	parser.setBuildParseTree(true)
	let tree = try parser.program()

	let ast = tree.toJKRTreeStatements()
	let writer = JKRStringWriter()
	let transpiler = JKRTranspiler(language: JKRObjcDataSource(),
	                               writingWith: writer)

	writer.changeFile("main")
	transpiler.transpileProgram(ast)

	try writer.files["main"]?.write(toFile: filePath + "main.m",
	                                atomically: false, encoding: .utf8)

	print("Done!")
}
catch (let error) {
	print("Failed :(")
	print(error)
}
