%{
    #include <bits/stdc++.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    using namespace std;
    void yyerror(char *);
    int yylex(void);
    int line_counter = 1;
    // extern int yydebug;

    string indent(const string &inp) {
        string res = "";

        for (char c : inp) {
            if (c == '\n') res = res + "\n    ";
            else res = res + c;
        }
        return res;
    }
%}

// %debug

%union {
    char* val;
    int indent;
}

%token <val> IDENTIFIER NUMBER
%type <val> int boolean arraytype type 
%token INT BOOLEAN ARRAYTYPE IF ELSE WHILE RETURN TRUE FALSE THIS NEW DO PRINT PUBLIC STATIC EXTENDS STRING DEFINE CLASS VOID MAIN LENGTH LE NE AND OR
%type <val> statements statement expression assignment while_block declaration 

%left OR
%left AND
%left LE NE
%left '+' '-'
%left '*' '/'

%%

program:
    CompoundMacroDefinition MainClass CompoundTypeDeclaration 
    ;

CompoundMacroDefinition:
    MacroDefinition CompoundMacroDefinition 
    |  /* empty */
    ;
 
CompoundTypeDeclaration:
    TypeDeclaration CompoundTypeDeclaration 
    |  /* empty */
    ;

MainClass:
    CLASS IDENTIFIER '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' IDENTIFIER ')' '{' statement '}' '}'
    ;
 
TypeDeclaration:
    CLASS IDENTIFIER '{'  CompoundDeclaration CompoundMethodDeclaration '}'
 
CompoundMethodDeclaration:
    MethodDeclaration CompoundMethodDeclaration 
    |  /* empty */
    ;
 
MethodDeclaration:
    PUBLIC type IDENTIFIER '(' parameters ')' '{' CompoundDeclaration statements RETURN expression ';' '}'

parameters:
    paramList
    |  /* empty */
    ;

paramList:
    declaration
    | declaration ',' paramList
    | /* empty */
    ;

CompoundDeclaration:
    declaration ';' CompoundDeclaration 
    | /* empty */
    ;

declaration:
    type IDENTIFIER
    ;

statements: 
    statement statements 
    | /* empty */
    ;

statement :
    expression
	| 	print_smt
	| 	assignment
    |   declaration
	| 	access
	| 	if_block
	| 	do_while_block
	| 	while_block
	| 	IDENTIFIER CompoundDeclaration ';'
    ;

CompoundExpression:
    expression ExpressionList
    | /* empty */
    ;

ExpressionList:
    ',' expression
    | /* empty */
    ;

print_smt:
    PRINT '(' expression ')' ';'

assignment:
    IDENTIFIER '=' expression ';'
    ;

access:
    IDENTIFIER '[' expression ']' '=' expression ';'
    ;

if_block:
    IF '(' expression ')' statements
    | IF '(' expression ')' statements ELSE statements
    ;

do_while_block:
    DO statements WHILE '(' expression ')' ';'
    ;

while_block:
    WHILE '(' expression ')' statements

expression:
    expression AND expression
	| 	expression OR expression
	| 	expression NE expression
	| 	expression LE expression
	| 	expression '+' expression
	| 	expression '-' expression
	| 	expression '*' expression
	| 	expression '/' expression
	| 	expression '[' expression ']'
	| 	expression '.' LENGTH
	| 	PrimaryExpression
	| 	expression '.' IDENTIFIER CompoundExpression
	| 	IDENTIFIER CompoundExpression
	| 	'(' IDENTIFIER ')' '-' '>' expression

PrimaryExpression:
    NUMBER
	| 	TRUE
	| 	FALSE
	| 	IDENTIFIER
    |   IDENTIFIER '(' ')'                  
    |   IDENTIFIER CompoundExpression
	| 	THIS
	| 	NEW INT '[' expression ']'
	| 	NEW IDENTIFIER '(' ')'
	| 	'!' expression
	| 	'(' expression ')'

MacroDefinition:
    MacroDefExpression
    | MacroDefStatement
    ;

MacroDefStatement:
    DEFINE CompoundIdentifierList '(' ')' '{' statements '}'
    
MacroDefExpression:
    DEFINE CompoundIdentifierList '(' ')' '(' expression ')'

CompoundIdentifierList:
    IDENTIFIER IdentifierList
    |  /* empty */
    ;

IdentifierList:
    ',' IDENTIFIER
    | /* empty */
    ;

type:
    int | boolean | arraytype | id
    ;

int:
   INT
   ;

boolean:
    BOOLEAN
    ;

arraytype:
    ARRAYTYPE
    ;

id:
    IDENTIFIER
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%d\n", line_counter);
    exit(1);
}

int main(int argc, char** argv) {
    // yydebug = 1;
    return yyparse();
}