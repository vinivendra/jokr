protocol JKRParser {
	func parse(file: String) throws -> [JKRTreeStatement]
}
