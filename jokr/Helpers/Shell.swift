import Foundation

enum Shell {
	struct CommandResult {
		let output: String
		let error: String
		let status: Int32
	}

	@discardableResult
	static func runEnvCommand(_ command: String) -> CommandResult {
		let outputPipe = Pipe()
		let errorPipe = Pipe()
		let arguments = command.components(separatedBy: " ")
		let task = Process()
		task.launchPath = "/usr/bin/env"
		task.arguments = arguments
		task.standardOutput = outputPipe
		task.standardError = errorPipe
		task.launch()
		task.waitUntilExit()

		let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
		let outputString = String(data: outputData, encoding: .utf8) ?? ""

		let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
		let errorString = String(data: errorData, encoding: .utf8) ?? ""

		return CommandResult(output: outputString,
		                     error: errorString,
		                     status: task.terminationStatus)
	}

	@discardableResult
	static func runCommand(_ command: String) -> CommandResult {
		let outputPipe = Pipe()
		let errorPipe = Pipe()
		let task = Process()
		task.launchPath = "/bin/bash"
		task.arguments = ["-c", command]
		task.standardOutput = outputPipe
		task.standardError = errorPipe
		task.launch()
		task.waitUntilExit()

		let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
		let outputString = String(data: outputData, encoding: .utf8) ?? ""

		let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
		let errorString = String(data: errorData, encoding: .utf8) ?? ""

		return CommandResult(output: outputString,
		                     error: errorString,
		                     status: task.terminationStatus)
	}

	@discardableResult
	static func runBinary(_ path: String) -> CommandResult {
		let outputPipe = Pipe()
		let errorPipe = Pipe()
		let task = Process()
		task.launchPath = path
		task.standardOutput = outputPipe
		task.standardError = errorPipe
		task.launch()
		task.waitUntilExit()

		let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
		let outputString = String(data: outputData, encoding: .utf8) ?? ""

		let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
		let errorString = String(data: errorData, encoding: .utf8) ?? ""

		return CommandResult(output: outputString,
		                     error: errorString,
		                     status: task.terminationStatus)
	}
}
