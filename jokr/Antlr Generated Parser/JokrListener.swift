// Generated from Jokr.g4 by ANTLR 4.7
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link JokrParser}.
 */
public protocol JokrListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link JokrParser#program}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterProgram(_ ctx: JokrParser.ProgramContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#program}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitProgram(_ ctx: JokrParser.ProgramContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#statementList}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStatementList(_ ctx: JokrParser.StatementListContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#statementList}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStatementList(_ ctx: JokrParser.StatementListContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#statement}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStatement(_ ctx: JokrParser.StatementContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#statement}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStatement(_ ctx: JokrParser.StatementContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#assignment}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAssignment(_ ctx: JokrParser.AssignmentContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#assignment}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAssignment(_ ctx: JokrParser.AssignmentContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#functionDeclaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFunctionDeclaration(_ ctx: JokrParser.FunctionDeclarationContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#functionDeclaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFunctionDeclaration(_ ctx: JokrParser.FunctionDeclarationContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#functionDeclarationHeader}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFunctionDeclarationHeader(_ ctx: JokrParser.FunctionDeclarationHeaderContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#functionDeclarationHeader}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFunctionDeclarationHeader(_ ctx: JokrParser.FunctionDeclarationHeaderContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#functionDeclarationParameters}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFunctionDeclarationParameters(_ ctx: JokrParser.FunctionDeclarationParametersContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#functionDeclarationParameters}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFunctionDeclarationParameters(_ ctx: JokrParser.FunctionDeclarationParametersContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#parameterDeclarationList}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterParameterDeclarationList(_ ctx: JokrParser.ParameterDeclarationListContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#parameterDeclarationList}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitParameterDeclarationList(_ ctx: JokrParser.ParameterDeclarationListContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#parameterDeclaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterParameterDeclaration(_ ctx: JokrParser.ParameterDeclarationContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#parameterDeclaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitParameterDeclaration(_ ctx: JokrParser.ParameterDeclarationContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#block}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterBlock(_ ctx: JokrParser.BlockContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#block}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitBlock(_ ctx: JokrParser.BlockContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterExpression(_ ctx: JokrParser.ExpressionContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitExpression(_ ctx: JokrParser.ExpressionContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#variableDeclaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterVariableDeclaration(_ ctx: JokrParser.VariableDeclarationContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#variableDeclaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitVariableDeclaration(_ ctx: JokrParser.VariableDeclarationContext)
	/**
	 * Enter a parse tree produced by {@link JokrParser#lvalue}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLvalue(_ ctx: JokrParser.LvalueContext)
	/**
	 * Exit a parse tree produced by {@link JokrParser#lvalue}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLvalue(_ ctx: JokrParser.LvalueContext)
}