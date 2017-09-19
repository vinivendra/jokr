import Antlr4

class JKRAntlrParser: JKRParser {
	func parse(file: String) throws -> JKRTree? {
		do {
			let contents = try String(contentsOfFile: file)
			let char = ANTLRInputStream(contents)
			let lexer = JokrLexer(char)
			let tokens = CommonTokenStream(lexer)
			let parser = try JokrParser(tokens)
			// parser.setTrace(true)
			parser.setBuildParseTree(true)
			let tree = try parser.program()

			if let statements = tree.toJKRTreeStatements() {
				return .statements(statements)
			}
			else if let classDeclarations = tree.toJKRTreeClasses() {
				return .classDeclarations(classDeclarations)
			}
			else {
				return nil
			}
		}
		catch (let error) {
			throw error
		}
	}
}
