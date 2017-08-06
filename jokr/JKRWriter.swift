/// Composable target for writing the transpiler's output, so the user can
/// switch between writing to the console, to a string, to a file, etc.
protocol JKRWriter {
	func write(_: String)
	func changeFile(_: String)
}

/// JKRWriter that writes to STDIN, using textual separators for separating 
/// files.
class JKRConsoleWriter: JKRWriter {
	func write(_ string: String) {
		print(string, terminator: "")
	}

	func changeFile(_ filename: String) {
		print("======================= \(filename) =======================")
	}
}

/// JKRWriter that builds a dictionary in which the keys are the filenames and 
/// the values are their contents.
class JKRStringWriter: JKRWriter {
	var files = [String: String]()
	private var currentFileName = ""

	func write(_ string: String) {
		guard let existingContents = files[currentFileName] else {
			fatalError("No filename given!")
		}
		files[currentFileName] = existingContents + string
	}

	func changeFile(_ filename: String) {
		files[filename] = ""
		currentFileName = filename
	}

	func prettyPrint() {
		for (filename, contents) in files {
			print("======================= \(filename) =======================")
			print(contents)
		}
	}
}
