// doc
// test
struct JKRObjcCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRObjcCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) throws -> Shell.CommandResult {
		log("======== Compiling ObjC...")

		let objcFiles = try Files.files(atFolder: folderPath,
		                                withExtension: "m")

		let filesString = objcFiles.map { "\"\(folderPath)\($0)\"" }
			.joined(separator: " ")

		let result = Shell.runCommand("""
			clang -framework Foundation \(filesString) \
			-o \"\(folderPath)a.out\"
			""")

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
		let result = Shell.runBinary("\(folderPath)a.out")

		if result.output != "" {
			log(result.output)
		}

		log("======== Program finished with status \(result.status)")

		return result
	}
}
