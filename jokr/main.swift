import Foundation
import Antlr4

do {
	print("Parsing...")
	let char = ANTLRInputStream("Int main() {\nInt x = 2\nreturn 0\n}\n")
	let lexer = JokrLexer(char)
	let tokens = CommonTokenStream(lexer)
	let parser = try JokrParser(tokens)
	parser.setBuildParseTree(true)
	let tree = try parser.program()
	let listener = ObjcCompilerListener()
	try ParseTreeWalker.DEFAULT.walk(listener, tree)

	print("Done!")
	print(listener.contents)
} catch (let error) {
	print("Failed :(")
	print(error)
}
