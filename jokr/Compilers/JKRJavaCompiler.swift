// doc
// test
struct JKRJavaCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRJavaCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) throws -> CInt {
		log("======== Compiling Java...")
		let result = Shell.runCommand("javac \"\(folderPath)Main.java\"")

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

		return 0
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> Shell.CommandResult {
		log("======== Running program...")
		let result = Shell.runCommand("cd \"\(folderPath)\" ;java -cp . Main ;")
		// swiftlint:disable:previous line_length

		if result.output != "" {
			log(result.output)
		}

		log("======== Program finished with status \(result.status)")

		return result
	}
}
