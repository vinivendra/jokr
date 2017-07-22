import Foundation
import Antlr4

do {
	print("Parsing...")
	let char = ANTLRInputStream("Int main() {\nString x = 2\nreturn 0\n}\n")
	let lexer = JokrLexer(char)
	let tokens = CommonTokenStream(lexer)
	let parser = try JokrParser(tokens)
	parser.setBuildParseTree(true)
	let tree = try parser.program()
	let listener = ObjcCompilerListener()
	listener.changeFile("main")
	try ParseTreeWalker.DEFAULT.walk(listener, tree)

	print("Done!")
} catch (let error) {
	print("Failed :(")
	print(error)
}
