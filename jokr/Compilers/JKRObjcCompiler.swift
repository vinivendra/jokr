// doc
// test
struct JKRObjcCompiler: JKRCompiler {
	static func create() -> JKRCompiler {
		return JKRObjcCompiler()
	}

	@discardableResult
	func compileFiles(atPath folderPath: String) -> CInt {
		log("======== Compiling Obj-C...")
		let (output, status) =
			Shell.runCommand("clang -framework Foundation \(folderPath)main.m -o \(folderPath)a.out")
		// swiftlint:disable:previous line_length
		if output != "" {
			log(output)
		}

		if status == 0 {
			log("======== Compilation succeeded!")
		}
		else {
			log("======== Compilation finished with status \(status)")
		}

		return status
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> CInt {
		log("======== Running program...")
		let (output, status) = Shell.runBinary(folderPath + "a.out")

		if output != "" {
			log(output)
		}

		log("======== Program finished with status \(status)")

		return status
	}
}
