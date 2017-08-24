/// Typesafe representations of elements in the jokr AST. Allows the actual
/// transpiler code to be independent from antlr, and makes it easier to reason
/// about given the type safety and the enum coverage.

struct JKRTreeProgram {
	let statements: [JKRTreeStatement]?
	let declarations: [JKRTreeDeclaration]?
}

enum JKRTreeStatement: Equatable {
	case assignment(JKRTreeAssignment)
	case functionCall(JKRTreeFunctionCall)
	case returnStm(JKRTreeReturn)

	// Equatable
	static func == (lhs: JKRTreeStatement, rhs: JKRTreeStatement) -> Bool {
		switch (lhs, rhs) {
		case let (.assignment(assignment1),
		          .assignment(assignment2)):
			return assignment1 == assignment2
		case let (.functionCall(functionCall1),
		          .functionCall(functionCall2)):
			return functionCall1 == functionCall2
		case let (.returnStm(returnStm1),
		          .returnStm(returnStm2)):
			return returnStm1 == returnStm2
		default:
			return false
		}
	}
}

enum JKRTreeDeclaration: Equatable {
	case functionDeclaration(JKRTreeFunctionDeclaration)

	var block: [JKRTreeStatement] {
		switch self {
		case let .functionDeclaration(functionDeclaration):
			return functionDeclaration.block
		}
	}

	static func == (lhs: JKRTreeDeclaration, rhs: JKRTreeDeclaration) -> Bool {
		switch (lhs, rhs) {
		case let (.functionDeclaration(functionDeclaration1),
		          .functionDeclaration(functionDeclaration2)):
			return functionDeclaration1 == functionDeclaration2
		}
	}
}

indirect enum JKRTreeExpression: Equatable, ExpressibleByIntegerLiteral,
ExpressibleByStringLiteral {
	case int(JKRTreeInt)
	case parenthesized(JKRTreeExpression)
	case operation(JKRTreeExpression, JKRTreeOperator, JKRTreeExpression)
	case lvalue(JKRTreeID)

	// Equatable
	static func == (lhs: JKRTreeExpression, rhs: JKRTreeExpression) -> Bool {
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

	// ExpressibleByStringLiteral
	init(stringLiteral value: String) { self = .lvalue(JKRTreeID(value)) }
	public init(extendedGraphemeClusterLiteral value: String) {
		self = .lvalue(JKRTreeID(value))
	}
	public init(unicodeScalarLiteral value: String) {
		self = .lvalue(JKRTreeID(value))
	}

	// ExpressibleByIntegerLiteral
	public init(integerLiteral value: Int) {
		self = .int(JKRTreeInt(value))
	}
}

enum JKRTreeAssignment: Equatable {
	case declaration(JKRTreeType, JKRTreeID, JKRTreeExpression)
	case assignment(JKRTreeID, JKRTreeExpression)

	// Equatable
	static func == (lhs: JKRTreeAssignment, rhs: JKRTreeAssignment) -> Bool {
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

struct JKRTreeFunctionCall: Equatable {
	let id: JKRTreeID

	// Equatable
	static func == (lhs: JKRTreeFunctionCall,
	                rhs: JKRTreeFunctionCall) -> Bool {
		return lhs.id == rhs.id
	}
}

struct JKRTreeReturn: Equatable, ExpressibleByIntegerLiteral,
ExpressibleByStringLiteral {
	let expression: JKRTreeExpression
	init(_ expression: JKRTreeExpression) { self.expression = expression }

	// Equatable
	static func == (lhs: JKRTreeReturn, rhs: JKRTreeReturn) -> Bool {
		return lhs.expression == rhs.expression
	}

	// ExpressibleByStringLiteral
	init(stringLiteral value: String) {
		self.expression = JKRTreeExpression(stringLiteral: value)
	}
	public init(extendedGraphemeClusterLiteral value: String) {
		self.expression = JKRTreeExpression(
			extendedGraphemeClusterLiteral: value)
	}
	public init(unicodeScalarLiteral value: String) {
		self.expression = JKRTreeExpression(unicodeScalarLiteral: value)
	}

	// ExpressibleByIntegerLiteral
	public init(integerLiteral value: Int) {
		self.expression = JKRTreeExpression(integerLiteral: value)
	}
}

struct JKRTreeParameterDeclaration: Equatable {
	let type: JKRTreeType
	let id: JKRTreeID

	// Equatable
	static func == (lhs: JKRTreeParameterDeclaration,
	                rhs: JKRTreeParameterDeclaration) -> Bool {
		return lhs.type == rhs.type && lhs.id == rhs.id
	}
}

struct JKRTreeFunctionDeclaration: Equatable {
	let type: JKRTreeType
	let id: JKRTreeID
	let parameters: [JKRTreeParameterDeclaration]
	let block: [JKRTreeStatement]

	// Equatable
	static func == (lhs: JKRTreeFunctionDeclaration,
	                rhs: JKRTreeFunctionDeclaration) -> Bool {
		return lhs.type == rhs.type && lhs.id == rhs.id &&
			lhs.parameters == rhs.parameters && lhs.block == rhs.block
	}
}

struct JKRTreeOperator: Equatable, ExpressibleByStringLiteral {
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
	static func == (lhs: JKRTreeOperator, rhs: JKRTreeOperator) -> Bool {
		return lhs.text == rhs.text
	}
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
	static func == (lhs: JKRTreeType, rhs: JKRTreeType) -> Bool {
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
	static func == (lhs: JKRTreeID, rhs: JKRTreeID) -> Bool {
		return lhs.text == rhs.text
	}
}

struct JKRTreeInt: Equatable, ExpressibleByIntegerLiteral {
	let value: Int
	init(_ value: Int) { self.value = value }

	// ExpressibleByStringLiteral
	public init(integerLiteral value: Int) { self.value = value }

	// Equatable
	static func == (lhs: JKRTreeInt, rhs: JKRTreeInt) -> Bool {
		return lhs.value == rhs.value
	}
}
