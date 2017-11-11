protocol JKRTranslator {
	static func create(writingWith: JKRWriter) -> JKRTranslator
	func translate(tree: JKRTree) throws
}
