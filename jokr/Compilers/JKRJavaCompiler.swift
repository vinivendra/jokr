// doc
// test
struct JKRJavaCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRJavaCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) -> CInt {
		log("======== Compiling Java...")
		let (output, status) = Shell.runCommand("javac \(folderPath)Main.java")
		if output != "" {
			log(output)
		}

		if status == 0 {
			log("======== Compilation succeeded!")
		}
		else {
			log("======== Compilation finished with status \(status)")
		}

		return 0
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> CInt {
		log("======== Running program...")
		let (output, status) = Shell.runCommand("cd \(folderPath) ;java -cp . Main ;")
		// swiftlint:disable:previous line_length

		if output != "" {
			log(output)
		}

		log("======== Program finished with status \(status)")

		return status
	}
}
