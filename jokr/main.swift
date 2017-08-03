import Foundation
import Antlr4

do {
	print("Parsing...")
	let char = ANTLRInputStream("Int main(Person a, Object b) {\nString x = 2\nreturn 0\n}\n")
	let lexer = JokrLexer(char)
	let tokens = CommonTokenStream(lexer)
	let parser = try JokrParser(tokens)
	parser.setBuildParseTree(true)
	let tree = try parser.program()

	let ast = tree.toJKRTreeStatements()
	let transpiler = JKRTranspiler(language: JKRObjcDataSource())
	transpiler.transpileProgram(ast)

	print("Done!")
} catch (let error) {
	print("Failed :(")
	print(error)
}
