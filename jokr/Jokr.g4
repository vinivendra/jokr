// Define a grammar called Hello
grammar Jokr;

// TODO: Change test orders to reflect rule order

////////////////////////////////////////////////////////////////////////////////
// Top level

program:
	// empty
	| statementList
	| statementList NEW_LINE
	| declarationList
	| declarationList NEW_LINE;

statementList:
	statement
	| statementList NEW_LINE statement;

statement:
	assignment
	| functionCall
	| returnStatement;

declarationList:
	declaration
	| declarationList NEW_LINE declaration;

declaration:
	functionDeclaration;

////////////////////////////////////////////////////////////////////////////////
// Building blocks

block:
	LBRACE NEW_LINE statementList NEW_LINE RBRACE;

lvalue:
	ID;

expression:
	INT
	| LPAREN expression RPAREN
	| expression OPERATOR expression
	| lvalue;

////////////////////////////////////////////////////////////////////////////////
// Statements

assignment:
	variableDeclaration ASSIGN expression
	| lvalue ASSIGN expression;

variableDeclaration:
	TYPE ID;

functionCall:
	ID LPAREN RPAREN;

returnStatement:
	RETURN expression;

////////////////////////////////////////////////////////////////////////////////
// Declarations

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

///////////////////////////////////////////////////////
BLOCK_COMMENT : '/*' (BLOCK_COMMENT|.)*? '*/' -> channel(HIDDEN);
LINE_COMMENT : '//' ~('\n')* -> channel(HIDDEN);
OPERATOR: OPERATOR_CHAR+;
OPERATOR_CHAR: '+' | '*' | '-' | '/';
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
COMMA: ',';
RETURN: 'return';
INT: [0-9]+;
TYPE: [_]*[A-Z][a-zA-Z0-9]*;
ID: [_]*[a-z][a-zA-Z0-9]*;
SNAKE_CASE: [a-zA-Z0-9_]+;
ASSIGN: '=';
NEW_LINE: '\n'+;

//
WS: [ \t\r]+ -> skip;
