// doc
// test
protocol JKRCompiler {
	@discardableResult func compileFiles(atPath: String) -> CInt
	@discardableResult func runProgram(atPath: String) -> CInt
}
