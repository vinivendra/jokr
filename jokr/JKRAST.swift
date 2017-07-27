// TODO: Consider changing Strings to opaque structs that only data sources can
// unravel

enum JKRTreeAssignment {
	case declaration(String, String, JKRTreeExpression)
	case assignment(String, JKRTreeExpression)
}

indirect enum JKRTreeExpression {
	case int(String)
	case parenthesized(JKRTreeExpression)
	case operation(JKRTreeExpression, String, JKRTreeExpression)
	case lvalue(String)
}

struct JKRTreeFunctionDeclaration {
	let type: String
	let id: String
	let parameters: [JKRTreeParameter]
}

struct JKRTreeParameter {
	let type: String
	let id: String
}
