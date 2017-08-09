// doc
// test
struct JKRObjcCompiler: JKRCompiler {
	@discardableResult
	func compileFiles(atPath folderPath: String) -> CInt {
		print("======== Compiling Obj-C...")
		let (output, status) =
			Shell.runCommand("clang -framework Foundation \(folderPath)main.m -o \(folderPath)a.out")
		// swiftlint:disable:previous line_length
		if output != "" {
			print(output)
		}

		if status == 0 {
			print("======== Compilation succeeded!")
		}
		else {
			print("======== Compilation finished with status \(status)")
		}

		return status
	}

	@discardableResult
	func runProgram(atPath folderPath: String) -> CInt {
		print("======== Running program...")
		let (output, status) = Shell.runBinary(folderPath + "a.out")

		if output != "" {
			print(output)
		}

		print("======== Program finished with status \(status)")

		return status
	}
}
