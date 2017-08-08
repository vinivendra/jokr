// doc
// test
struct JKRJavaCompiler: JKRCompiler {
	@discardableResult
	func compileFiles(atPath folderPath: String) -> CInt {
		print("======== Compiling Java...")
		let (output, status) = Shell.runCommand("javac \(folderPath)Main.java")
		if output != "" {
			print(output)
		}

		if status == 0 {
			print("======== Compilation succeeded!")
		}
		else {
			print("======== Compilation finished with status \(status)")
		}

		return 0
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> CInt {
		print("======== Running program...")
		let (output, status) = Shell.runCommand("cd \(folderPath) ;java -cp . Main ;")
		// swiftlint:disable:previous line_length

		if output != "" {
			print(output)
		}

		print("======== Program finished with status \(status)")

		return status
	}
}
