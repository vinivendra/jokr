import Foundation

enum JKRTargetLanguage {
	case java
	case objectiveC
	case swift
	case kotlin

	var translator: JKRTranslator.Type {
		switch self {
		case .java:
			return JKRJavaTranslator.self
		case .objectiveC:
			return JKRObjcTranslator.self
		case .swift:
			return JKRSwiftTranslator.self
		case .kotlin:
			return JKRKotlinTranslator.self
		}
	}

	var compiler: JKRCompiler.Type {
		switch self {
		case .java:
			return JKRJavaCompiler.self
		case .objectiveC:
			return JKRObjcCompiler.self
		case .swift:
			return JKRSwiftCompiler.self
		case .kotlin:
			return JKRKotlinCompiler.self
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

enum Files {
	static func trashFiles(atFolder folderPath: String) throws {
		let fileManager = FileManager.default

		// Move all files in folder to trash, except for hidden files.
		for file in try fileManager.contentsOfDirectory(atPath: folderPath)
			where !file.hasPrefix(".")
		{
			let url = URL(fileURLWithPath: folderPath + file)
			try fileManager.trashItem(at: url, resultingItemURL: nil)
		}
	}

	static func trashFiles(atFolder folderPath: String,
	                       skippingFiles filesToSkip: [String]) throws {
		let fileManager = FileManager.default

		for file in try fileManager.contentsOfDirectory(atPath: folderPath)
			where !filesToSkip.contains(file)
		{
			let url = URL(fileURLWithPath: folderPath + file)
			try fileManager.trashItem(at: url, resultingItemURL: nil)
		}
	}

	static func files(atFolder folderPath: String,
	                  withExtension ext: String) throws -> [String] {
		let fileManager = FileManager.default
		var result = [String]()

		for file in try fileManager.contentsOfDirectory(atPath: folderPath)
			where file.hasSuffix("." + ext)
		{
			result.append(file)
		}

		return result
	}
}
