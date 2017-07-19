protocol JKRWriter {
	func write(_: String)
	func changeFile(_: String)
}

class JKRConsoleWriter: JKRWriter {
	func write(_ string: String) {
		print(string, terminator: "")
	}

	func changeFile(_ filename: String) {
		print("======================= \(filename) =======================")
	}
}

class JKRStringWriter: JKRWriter {
	var files = [String: String]()
	private var currentFileName = ""

	func write(_ string: String) {
		guard let existingContents = files[currentFileName] else {
			assertionFailure("No filename given!")
			return
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
