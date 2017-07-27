/// Typesafe representations of elements in the jokr AST. Allows the actual 
/// transpiler code to be independent from antlr, and makes it easier to reason
/// about given the type safety and the enum coverage.

enum JKRTreeAssignment {
	case declaration(JKRTreeType, JKRTreeID, JKRTreeExpression)
	case assignment(JKRTreeID, JKRTreeExpression)
}

indirect enum JKRTreeExpression {
	case int(String)
	case parenthesized(JKRTreeExpression)
	case operation(JKRTreeExpression, String, JKRTreeExpression)
	case lvalue(JKRTreeID)
}

struct JKRTreeFunctionDeclaration {
	let type: JKRTreeType
	let id: JKRTreeID
	let parameters: [JKRTreeParameter]
}

struct JKRTreeParameter {
	let type: JKRTreeType
	let id: JKRTreeID
}

struct JKRTreeType {
	let text: String
	init(_ text: String) { self.text = text }
}

struct JKRTreeID {
	let text: String
	init(_ text: String) { self.text = text }
}
