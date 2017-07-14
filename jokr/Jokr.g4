// Define a grammar called Hello
grammar Jokr;

program:
	// empty
	| statementList
	| statementList NEW_LINE;

statementList:
	statement
	| statementList NEW_LINE statement;

statement:
	assignment;

assignment:
	variableDeclaration ASSIGN expression
	| lvalue ASSIGN expression;

expression:
	INT
	| LPAREN expression RPAREN
	| expression OPERATOR expression
	| lvalue;

variableDeclaration:
	TYPE ID;

lvalue:
	ID;

///////////////////////////////////////////////////////
BLOCK_COMMENT : '/*' (BLOCK_COMMENT|.)*? '*/' -> channel(HIDDEN);
LINE_COMMENT : '//' ~('\n')* -> channel(HIDDEN);
OPERATOR: OPERATOR_CHAR+;
OPERATOR_CHAR: '+' | '*' | '-' | '/';
LPAREN: [(];
RPAREN: [)];
INT: [0-9]+;
TYPE: [_]*[A-Z][a-zA-Z0-9]*;
ID: [_]*[a-z][a-zA-Z0-9]*;
SNAKE_CASE: [a-zA-Z0-9_]+;
ASSIGN: '=';
NEW_LINE: '\n'+;

//
WS: [ \t\r]+ -> skip;
