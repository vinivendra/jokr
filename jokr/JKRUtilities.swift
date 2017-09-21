import Foundation

enum JKRTargetLanguage {
	case java
	case objectiveC

	var translator: JKRTranslator.Type {
		switch self {
		case .java:
			return JKRJavaTranslator.self
		case .objectiveC:
			return JKRObjcTranslator.self
		}
	}

	var compiler: JKRCompiler.Type {
		switch self {
		case .java:
			return JKRJavaCompiler.self
		case .objectiveC:
			return JKRObjcCompiler.self
		}
	}
}

enum JKRError: Error {
	case parsing
	/// Clang or javac errors
	case compilation(CInt)
}

func log(_ string: String) {
	if jkrDebug {
		print(string)
	}
}

var jkrDebug: Bool = true

func trashFiles(atFolder folderPath: String) throws {
	do {
		let fileManager = FileManager.default

		// Move all files in folder to trash, except for hidden files.
		for file in try fileManager.contentsOfDirectory(atPath: folderPath)
			where !file.hasPrefix(".")
		{
			let url = URL(fileURLWithPath: folderPath + file)
			try fileManager.trashItem(at: url, resultingItemURL: nil)
		}
	}
	catch (let error) {
		throw error
	}
}

func trashFiles(atFolder folderPath: String,
                skippingFiles filesToSkip: [String]) throws {
	do {
		let fileManager = FileManager.default

		for file in try fileManager.contentsOfDirectory(atPath: folderPath)
			where !filesToSkip.contains(file)
		{
			let url = URL(fileURLWithPath: folderPath + file)
			try fileManager.trashItem(at: url, resultingItemURL: nil)
		}
	}
	catch (let error) {
		throw error
	}
}
