// doc
// test
struct JKRObjcCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRObjcCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) throws -> Shell.CommandResult {
		let result =
			Shell.runCommand("clang -framework Foundation \"\(folderPath)main.m\" -o \"\(folderPath)a.out\"")
		// swiftlint:disable:previous line_length
		if result.output != "" {
			log(result.output)
		}

		if result.status != 0 {
			log("================")
			log(result.output)
			log("================")
			log(result.error)
			throw JKRError.compilation(result.status)
		}

		return result
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> Shell.CommandResult {
		let result = Shell.runBinary("\(folderPath)a.out")

		if result.output != "" {
			log(result.output)
		}

		return result
	}

	@discardableResult
	func runProgramToSTDERR(atPath folderPath: String) -> Shell.CommandResult {
		let result = Shell.runBinary("\(folderPath)a.out")

		if result.output != "" {
			log(result.output)
		}

		return result
	}
}
