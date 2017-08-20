// doc
// test
protocol JKRCompiler {
	static func create() -> JKRCompiler
	@discardableResult func compileFiles(atPath: String) throws -> CInt
	@discardableResult func runProgram(atPath: String) -> Shell.CommandResult
}
