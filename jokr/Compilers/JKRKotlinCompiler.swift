// doc
// test
struct JKRKotlinCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRKotlinCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) throws -> Shell.CommandResult {
		log("======== Compiling Kotlin...")

		let swiftFiles = try Files.files(atFolder: folderPath,
										 withExtension: "kt")

		let filesString = swiftFiles.map { "\"\(folderPath)\($0)\"" }
			.joined(separator: " ")

		let result = Shell.runCommand("""
			/usr/local/bin/kotlinc \(filesString) \
			-include-runtime \
			-d \"\(folderPath)kotlin.jar\"
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
		let result = Shell.runCommand("java -jar \"\(folderPath)kotlin.jar\"")

		if result.output != "" {
			log(result.output)
		}

		log("======== Program finished with status \(result.status)")

		return result
	}
}
