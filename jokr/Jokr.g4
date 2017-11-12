// Define a grammar called Hello
grammar Jokr;

////////////////////////////////////////////////////////////////////////////////
// Top level

program:
	// empty
	| statementList
	| statementList NEW_LINE
	| classDeclarationList
	| classDeclarationList NEW_LINE;

statementList:
	statement
	| statementList NEW_LINE statement;

statement:
	assignment
	| returnStatement
	| functionCall
	| methodCall;

classDeclarationList:
	classDeclaration
	| classDeclarationList NEW_LINE classDeclaration;

////////////////////////////////////////////////////////////////////////////////
// Building blocks

block:
	LBRACE NEW_LINE RBRACE
	| LBRACE NEW_LINE statementList NEW_LINE RBRACE;

lvalue:
	ID;

expression:
	INT
	| DECIMAL
	| LPAREN expression RPAREN
	| expression OPERATOR expression
	| lvalue
	| constructorCall
	| functionCall
	| methodCall;

////////////////////////////////////////////////////////////////////////////////
// Statements

parameterList:
	// empty
	| parameter
	| parameterList COMMA parameter;

parameter:
	expression;

assignment:
	variableDeclaration ASSIGN expression
	| lvalue ASSIGN expression;

variableDeclaration:
	TYPE ID;

returnStatement:
	RETURN expression;

constructorCall:
	TYPE LPAREN parameterList RPAREN;

functionCall:
	ID LPAREN parameterList RPAREN;

methodCall:
	ID NEW_LINE? PERIOD NEW_LINE? functionCall;

////////////////////////////////////////////////////////////////////////////////
// Declarations

// Class declarations
classDeclaration:
	CLASS TYPE LBRACE NEW_LINE RBRACE // empty class
	| CLASS TYPE LBRACE NEW_LINE classMemberList NEW_LINE RBRACE;

// Class members
classMemberList:
	// empty
	| classMember
	| classMemberList NEW_LINE classMember;

classMember:
	functionDeclaration;

// Function declarations
functionDeclaration:
	functionDeclarationHeader functionDeclarationParameters block;

functionDeclarationHeader:
	TYPE ID;

functionDeclarationParameters:
	LPAREN parameterDeclarationList RPAREN;

parameterDeclarationList:
	// empty
	| parameterDeclaration
	| parameterDeclarationList COMMA parameterDeclaration;

parameterDeclaration:
	TYPE ID;

////////////////////////////////////////////////////////////////////////////////
// Keywords
CLASS: 'class';

// Tokens
BLOCK_COMMENT : '/*' (BLOCK_COMMENT|.)*? '*/' -> channel(HIDDEN);
LINE_COMMENT : '//' ~('\n')* -> channel(HIDDEN);
OPERATOR: OPERATOR_CHAR+;
OPERATOR_CHAR: '+' | '*' | '-' | '/';
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
COMMA: ',';
PERIOD: '.';
RETURN: 'return';
INT: [0-9]+;
DECIMAL: INT PERIOD INT | PERIOD INT;
TYPE: [_]*[A-Z][a-zA-Z0-9]*;
ID: [_]*[a-z][a-zA-Z0-9]*;
SNAKE_CASE: [a-zA-Z0-9_]+;
ASSIGN: '=';
NEW_LINE: '\n'+ | ('\n'[ \t\r]*)+;

//
WS: [ \t\r]+ -> skip;
