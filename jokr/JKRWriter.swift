/// Composable target for writing the transpiler's output, so the user can
/// switch between writing to the console, to a string, to a file, etc.
protocol JKRWriter {
	func write(_: String)
	func changeFile(_: String)
	// test
	var currentFileName: String { get }
	func finishWriting() throws
}

extension JKRWriter {
	func finishWriting() throws { }
}

/// JKRWriter that writes to STDIN, using textual separators for separating 
/// files.
class JKRConsoleWriter: JKRWriter {
	private(set) var currentFileName = ""

	func write(_ string: String) {
		print(string, terminator: "")
	}

	func changeFile(_ filename: String) {
		print("======================= \(filename) =======================")
		currentFileName = filename
	}
}

/// JKRWriter that builds a dictionary in which the keys are the filenames and 
/// the values are their contents.
class JKRStringWriter: JKRWriter {
	var files = [String: String]()
	private(set) var currentFileName = ""

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

/// JKRWriter that accumulates the file contents in memory then writes them to 
/// the appropriate files in the given directory.
class JKRFileWriter: JKRWriter {
	private var files = [String: String]()
	private var outputDirectory: String
	private var fileExtension: String

	init(outputDirectory: String, fileExtension: String) {
		self.outputDirectory = outputDirectory
		self.fileExtension = fileExtension
	}

	func prettyPrint() {
		for (filename, contents) in files {
			print("======================= \(filename) =======================")
			print(contents)
		}
	}

	// JKRWriter
	private(set) var currentFileName = ""

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

	func finishWriting() throws {
		for (filename, contents) in files {
			let path = outputDirectory + filename + "." + fileExtension
			do {
				try contents.write(toFile: path,
				                   atomically: false,
				                   encoding: .utf8)
			}
			catch (let error) {
				throw error
			}
		}
	}
}
