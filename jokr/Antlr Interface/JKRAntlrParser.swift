import Antlr4

class JKRAntlrParser: JKRParser {
	func parse(file: String) throws -> [JKRTreeStatement] {
		do {
			log("Parsing...")
			let contents = try String(contentsOfFile: file)
			let char = ANTLRInputStream(contents)
			let lexer = JokrLexer(char)
			let tokens = CommonTokenStream(lexer)
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			let statements = tree.toJKRTreeStatements()
			return statements
		}
		catch (let error) {
			throw error
		}
	}
}
