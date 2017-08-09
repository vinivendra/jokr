// doc
// test
protocol JKRCompiler {
	static func create() -> JKRCompiler
	@discardableResult func compileFiles(atPath: String) -> CInt
	@discardableResult func runProgram(atPath: String) -> CInt
}
