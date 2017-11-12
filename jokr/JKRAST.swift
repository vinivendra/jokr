/// Typesafe representations of elements in the jokr AST. Allows the actual
/// transpiler code to be independent from antlr, and makes it easier to reason
/// about given the type safety and the enum coverage.

enum JKRTree {
	case statements([JKRTreeStatement])
	case classDeclarations([JKRTreeClassDeclaration])
}

enum JKRTreeStatement: Equatable {
	case assignment(JKRTreeAssignment)
	case returnStm(JKRTreeReturn)
	case functionCall(JKRTreeFunctionCall)
	case methodCall(JKRTreeMethodCall)

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
		case let (.methodCall(methodCall1),
		          .methodCall(methodCall2)):
			return methodCall1 == methodCall2
		default:
			return false
		}
	}
}

indirect enum JKRTreeExpression: Equatable, ExpressibleByIntegerLiteral,
ExpressibleByFloatLiteral, ExpressibleByStringLiteral {
	case int(JKRTreeInt)
	case decimal(JKRTreeDecimal)
	case parenthesized(JKRTreeExpression)
	case operation(JKRTreeExpression, JKRTreeOperator, JKRTreeExpression)
	case lvalue(JKRTreeID)
	case constructorCall(JKRTreeConstructorCall)
	case functionCall(JKRTreeFunctionCall)
	case methodCall(JKRTreeMethodCall)

	// Equatable
	static func == (lhs: JKRTreeExpression, rhs: JKRTreeExpression) -> Bool {
		switch (lhs, rhs) {
		case let (.int(int1),
		          .int(int2)):
			return int1 == int2
		case let (.decimal(decimal1),
				  .decimal(decimal2)):
			return decimal1 == decimal2
		case let (.parenthesized(exp1),
		          .parenthesized(exp2)):
			return exp1 == exp2
		case let (.operation(exp11, op1, exp12),
		          .operation(exp21, op2, exp22)):
			return exp11 == exp21 && op1 == op2 && exp12 == exp22
		case let (.lvalue(id1),
		          .lvalue(id2)):
			return id1 == id2
		case let (.methodCall(methodCall1),
				  .methodCall(methodCall2)):
			return methodCall1 == methodCall2
		case let (.functionCall(functionCall1),
				  .functionCall(functionCall2)):
			return functionCall1 == functionCall2
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

	// ExpressibleByFloatLiteral
	public init(floatLiteral value: Float) {
		self = .decimal(JKRTreeDecimal(value))
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
	let parameters: [JKRTreeExpression]

	init(id: JKRTreeID, parameters: [JKRTreeExpression]) {
		self.id = id
		self.parameters = parameters
	}

	init(id: JKRTreeID) {
		self.id = id
		self.parameters = []
	}

	// Equatable
	static func == (lhs: JKRTreeFunctionCall,
	                rhs: JKRTreeFunctionCall) -> Bool {
		return lhs.id == rhs.id && rhs.parameters == lhs.parameters
	}
}

struct JKRTreeConstructorCall: Equatable {
	let type: JKRTreeType
	let parameters: [JKRTreeExpression]

	init(type: JKRTreeType, parameters: [JKRTreeExpression]) {
		self.type = type
		self.parameters = parameters
	}

	init(type: JKRTreeType) {
		self.type = type
		self.parameters = []
	}

	// Equatable
	static func == (lhs: JKRTreeConstructorCall, rhs: JKRTreeConstructorCall)
		-> Bool
	{
		return lhs.type == rhs.type && rhs.parameters == lhs.parameters
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

struct JKRTreeMethodCall: Equatable {
	let object: JKRTreeID
	let method: JKRTreeID
	let parameters: [JKRTreeExpression]

	init(object: JKRTreeID, method: JKRTreeID, parameters: [JKRTreeExpression])
	{
		self.object = object
		self.method = method
		self.parameters = parameters
	}

	init(object: JKRTreeID, method: JKRTreeID) {
		self.object = object
		self.method = method
		self.parameters = []
	}

	// Equatable
	static func == (lhs: JKRTreeMethodCall, rhs: JKRTreeMethodCall) -> Bool {
		return lhs.object == rhs.object &&
			lhs.method == rhs.method &&
			rhs.parameters == lhs.parameters
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

struct JKRTreeClassDeclaration: Equatable {
	let type: JKRTreeType
	let methods: [JKRTreeFunctionDeclaration]

	init(type: JKRTreeType, methods: [JKRTreeFunctionDeclaration] = []) {
		self.type = type
		self.methods = methods
	}

	// Equatable
	static func == (lhs: JKRTreeClassDeclaration,
	                rhs: JKRTreeClassDeclaration) -> Bool {
		return lhs.type == rhs.type && lhs.methods == rhs.methods
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

	// ExpressibleByIntLiteral
	public init(integerLiteral value: Int) { self.value = value }

	// Equatable
	static func == (lhs: JKRTreeInt, rhs: JKRTreeInt) -> Bool {
		return lhs.value == rhs.value
	}
}

struct JKRTreeDecimal: Equatable, ExpressibleByFloatLiteral {
	let value: Float
	init(_ value: Float) { self.value = value }

	// ExpressibleByFloatLiteral
	public init(floatLiteral value: Float) { self.value = value }

	// Equatable
	static func == (lhs: JKRTreeDecimal, rhs: JKRTreeDecimal) -> Bool {
		return lhs.value == rhs.value
	}
}
