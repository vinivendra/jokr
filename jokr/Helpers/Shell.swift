import Foundation

enum Shell {
	typealias CommandResult = (output: String, status: Int32)

	@discardableResult
	static func runEnvCommand(_ command: String) -> CommandResult {
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
	static func runCommand(_ command: String) -> CommandResult {
		let pipe = Pipe()
		let task = Process()
		task.launchPath = "/bin/bash"
		task.arguments = ["-c", command]
		task.standardOutput = pipe
		task.launch()
		task.waitUntilExit()
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let string = String(data: data, encoding: .utf8) ?? ""

		return (string, task.terminationStatus)
	}

	@discardableResult
	static func runBinary(_ path: String) -> CommandResult {
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
