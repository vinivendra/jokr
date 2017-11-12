import Foundation
import Antlr4

// Branch - ClassDeclarations

// TODO: Add method calls
	// ✅ Add method calls to the grammar
	// ✅ Add method calls to the AST
	// ✅ Add AntlrToJokr methods
	// ✅ Test Parser
	// ✅ Test AntlrToJokr
	// ✅ Test AST
	// ✅ Add and test Java Translator
	// ✅ Test Swift (Acceptance)
	// ✅ Test Kotlin (Acceptance)
	// Look into using method calls to test other things (soundness, semantic
		// properties, etc)
	// Improve order of things in grammar (statements, expressions)
	// Add tests for other expressions
	// Add lexer->AST tests for constructors

// TODO: Add properties

private let filePath = CommandLine.arguments[1] + "/example/"

do {
	let driver = JKRDriver(folderPath: filePath,
	                       parser: JKRAntlrParser(),
	                       language: .kotlin)

	try driver.transpile()
	driver.run()
}
catch (let error) {
	log("Failed :(")
	log("\(error)")
}
