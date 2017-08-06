import Foundation
import Antlr4

private let filePath = CommandLine.arguments[1] + "/tests/"

do {
	print("Parsing...")
	let char = ANTLRInputStream(
		"Int x = 2\nInt y = x - x\nreturn 1\n")
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

	print("======== Compiling Obj-C... ========")
	let (output, status) =
		Shell.runCommand("clang -framework Foundation \(filePath)main.m -o \(filePath)main")
	// swiftlint:disable:previous line_length
	print(output)

	if status == 0 {
		print("======== Compilation succeeded! ========")
		print("======== Running program... ========")
		let (output, status) =
			Shell.runBinary(filePath + "main")
		print(output)
		print("======== Program finished with status \(status) ========")
	}
	else {
		print("======== Compilation finished with status \(status) ========")
	}

	print("Done!")
}
catch (let error) {
	print("Failed :(")
	print(error)
}
