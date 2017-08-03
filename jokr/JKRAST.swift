/// Typesafe representations of elements in the jokr AST. Allows the actual 
/// transpiler code to be independent from antlr, and makes it easier to reason
/// about given the type safety and the enum coverage.

enum JKRTreeStatement {
	case assignment(JKRTreeAssignment)
	case functionDeclaration(JKRTreeFunctionDeclaration)
	case returnStm(JKRTreeExpression)

	var block: [JKRTreeStatement]? {
		switch self {
		case let .functionDeclaration(functionDeclaration):
			return functionDeclaration.block
		case .assignment, .returnStm:
			return nil
		}
	}
}

enum JKRTreeAssignment: Equatable {
	case declaration(JKRTreeType, JKRTreeID, JKRTreeExpression)
	case assignment(JKRTreeID, JKRTreeExpression)

	static func ==(lhs: JKRTreeAssignment, rhs: JKRTreeAssignment) -> Bool {
		switch (lhs, rhs) {
		case let (.declaration(type1, id1, exp1),
		          .declaration(type2, id2, exp2)):
			return type1 == type2 && id1 == id2 && exp1 == exp2
		case let (.assignment(id1, exp1),
		          .assignment(id2, exp2)):
			return id1 == id2 && exp1 == exp2
		default:
			return false
		}
	}
}

indirect enum JKRTreeExpression: Equatable {
	case int(String)
	case parenthesized(JKRTreeExpression)
	case operation(JKRTreeExpression, String, JKRTreeExpression)
	case lvalue(JKRTreeID)

	static func ==(lhs: JKRTreeExpression, rhs: JKRTreeExpression) -> Bool {
		switch (lhs, rhs) {
		case let (.int(int1),
		          .int(int2)):
			return int1 == int2
		case let (.parenthesized(exp1),
		          .parenthesized(exp2)):
			return exp1 == exp2
		case let (.operation(exp11, op1, exp12),
		          .operation(exp21, op2, exp22)):
			return exp11 == exp21 && op1 == op2 && exp12 == exp22
		case let (.lvalue(id1),
		          .lvalue(id2)):
			return id1 == id2
		default:
			return false
		}
	}
}

struct JKRTreeFunctionDeclaration {
	let type: JKRTreeType
	let id: JKRTreeID
	let parameters: [JKRTreeParameter]
	let block: [JKRTreeStatement]
}

struct JKRTreeParameter {
	let type: JKRTreeType
	let id: JKRTreeID
}

struct JKRTreeType: Equatable, ExpressibleByStringLiteral {
	let text: String
	init(_ text: String) { self.text = text }

	// ExpressibleByStringLiteral
	init(stringLiteral value: String) { self.text = value }
	public init(extendedGraphemeClusterLiteral value: String) {
		self.text = value
	}
	public init(unicodeScalarLiteral value: String) {
		self.text = value
	}

	// Equatable
	static func ==(lhs: JKRTreeType, rhs: JKRTreeType) -> Bool {
		return lhs.text == rhs.text
	}
}

struct JKRTreeID: Equatable, ExpressibleByStringLiteral {
	let text: String
	init(_ text: String) { self.text = text }

	// ExpressibleByStringLiteral
	init(stringLiteral value: String) { self.text = value }
	public init(extendedGraphemeClusterLiteral value: String) {
		self.text = value
	}
	public init(unicodeScalarLiteral value: String) {
		self.text = value
	}

	// Equatable
	static func ==(lhs: JKRTreeID, rhs: JKRTreeID) -> Bool {
		return lhs.text == rhs.text
	}
}
