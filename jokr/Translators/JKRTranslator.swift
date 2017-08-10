protocol JKRTranslator {
	static func create(writingWith: JKRWriter) -> JKRTranslator
	func translate(program: JKRTreeProgram) throws
}
