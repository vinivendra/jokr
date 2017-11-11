// doc
// test
struct JKRJavaCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRJavaCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) throws -> Shell.CommandResult {
		log("======== Compiling Java...")

		let javaFiles = try Files.files(atFolder: folderPath,
		                                withExtension: "java")

		let filesString = javaFiles.map { "\"\(folderPath)\($0)\"" }
			.joined(separator: " ")

		let result = Shell.runCommand("javac " + filesString)

		log(result.output)
		log(result.error)

		if result.status == 0 {
			log("======== Compilation succeeded!")
		}
		else {
			log("======== Compilation failed with status \(result.status)")
			throw JKRError.compilation(result.status)
		}

		return result
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> Shell.CommandResult {
		log("======== Running program...")
		let result = Shell.runCommand("cd \"\(folderPath)\" ;java -cp . Main ;")

		if result.output != "" {
			log(result.output)
		}

		log("======== Program finished with status \(result.status)")

		return result
	}
}
