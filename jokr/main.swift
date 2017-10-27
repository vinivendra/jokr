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
	// Add and test Java Translator
	// Add and test ObjC Translator
	// Test Java (Acceptance)
	// Test ObjC (Appectance)
	// Look into using method calls to test other things (soundness, semantic
		// properties, etc)
	// Make the order of possible statements constant (i.e. assignment,
		// returnStm, functionCall, methodCall)

// TODO: Add properties

private let filePath = CommandLine.arguments[1] + "/example/"

do {
	let driver = JKRDriver(folderPath: filePath,
	                       parser: JKRAntlrParser(),
	                       language: .java)

	// TODO: Trash build files

	try driver.transpile()
	driver.run()
}
catch (let error) {
	log("Failed :(")
	log("\(error)")
}
