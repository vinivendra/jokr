// doc
// test
struct JKRObjcCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRObjcCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) throws -> CInt {
		log("======== Compiling Obj-C...")
		let result =
			Shell.runCommand("clang -framework Foundation \"\(folderPath)main.m\" -o \"\(folderPath)a.out\"")
		// swiftlint:disable:previous line_length
		if result.output != "" {
			log(result.output)
		}

		if result.status == 0 {
			log("======== Compilation succeeded!")
		}
		else {
			log("======== Compilation failed with status \(result.status)")
			throw JKRError.compilation(result.status)
		}

		return result.status
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> Shell.CommandResult {
		log("======== Running program...")
		let result = Shell.runBinary("\(folderPath)a.out")

		if result.output != "" {
			log(result.output)
		}

		log("======== Program finished with status \(result.status)")

		return result
	}

	@discardableResult
	func runProgramToSTDERR(atPath folderPath: String) -> Shell.CommandResult {

		log("======== Running program...")
		let result = Shell.runBinary("\(folderPath)a.out")

		if result.output != "" {
			log(result.output)
		}

		log("======== Program finished with status \(result.status)")

		return result
	}
}
