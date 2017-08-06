import Foundation

enum Shell {
	@discardableResult
	static func runCommand(_ command: String)
		-> (output: String, status: Int32)
	{
		let arguments = command.components(separatedBy: " ")
		let pipe = Pipe()
		let task = Process()
		task.launchPath = "/usr/bin/env"
		task.arguments = arguments
		task.standardOutput = pipe
		task.launch()
		task.waitUntilExit()
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let string = String(data: data, encoding: .utf8) ?? ""

		return (string, task.terminationStatus)
	}

	@discardableResult
	static func runBinary(_ path: String) -> (output: String, status: Int32) {
		let pipe = Pipe()
		let task = Process()
		task.launchPath = path
		task.standardOutput = pipe
		task.launch()
		task.waitUntilExit()
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let string = String(data: data, encoding: .utf8) ?? ""

		return (string, task.terminationStatus)
	}
}
