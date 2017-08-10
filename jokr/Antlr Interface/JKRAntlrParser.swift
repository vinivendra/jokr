import Antlr4

class JKRAntlrParser: JKRParser {
	func parse(file: String) throws -> JKRTreeProgram {
		do {
			log("Parsing...")
			let contents = try String(contentsOfFile: file)
			let char = ANTLRInputStream(contents)
			let lexer = JokrLexer(char)
			let tokens = CommonTokenStream(lexer)
			let parser = try JokrParser(tokens)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			if let statements = tree.toJKRTreeStatements() {
				return JKRTreeProgram(statements: statements,
				                      declarations: [])
			}
			else if let declarations = tree.toJKRTreeDeclarations() {
				return JKRTreeProgram(statements: [],
				                      declarations: declarations)
			}
			else {
				return JKRTreeProgram(statements: [],
				                      declarations: [])
			}
		}
		catch (let error) {
			throw error
		}
	}
}
