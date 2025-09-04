%{
    #include <bits/stdc++.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    using namespace std;
    void yyerror(char *);
    int yylex(void);
    int line_counter = 1;
    extern int yydebug;

    string indent(const string &inp) {
        string res = "";

        for (char c : inp) {
            if (c == '\n') res = res + "\n    ";
            else res = res + c;
        }
        return res;
    }

    map<string, string> macros;
%}

%debug

%union {
    char* val;
    int indent;
}

%token <val> IDENTIFIER NUMBER
%type <val> int boolean arraytype type 
%token INT BOOLEAN ARRAYTYPE IF ELSE WHILE RETURN TRUE FALSE THIS NEW DO PRINT PUBLIC STATIC EXTENDS STRING DEFINE CLASS VOID MAIN LENGTH LE NE AND OR
%type <val> CompoundStatement statement expression assignment while_block declaration MacroDefinition MacroDefExpression MacroDefStatement
%type <val> program CompoundMacroDefinition MainClass CompoundTypeDeclaration TypeDeclaration CompoundMethodDeclaration MethodDeclaration
%type <val> parameters paramList CompoundDeclaration print_smt access if_block do_while_block PrimaryExpression
%type <val> CompoundExpression ExpressionList CompoundIdentifierList IdentifierList userType lambda

%left OR
%left AND
%left LE NE
%left '+' '-'
%left '*' '/'
%right '!'
%left '.' '[' '('

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%%

program:
    CompoundMacroDefinition MainClass CompoundTypeDeclaration 
    ;

CompoundMacroDefinition:
    CompoundMacroDefinition MacroDefinition  
    |  /* empty */
    ;
 
CompoundTypeDeclaration:
    CompoundTypeDeclaration TypeDeclaration  
    |  /* empty */
    ;

MainClass:
    CLASS IDENTIFIER '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' IDENTIFIER ')' '{' print_smt '}' '}'
    ;
 
TypeDeclaration:
    CLASS IDENTIFIER '{'  CompoundDeclaration CompoundMethodDeclaration '}'
    | CLASS IDENTIFIER EXTENDS IDENTIFIER '{' CompoundDeclaration CompoundMethodDeclaration '}'
    ;
 
CompoundMethodDeclaration:
    CompoundMethodDeclaration MethodDeclaration  
    |  /* empty */
    ;
 
MethodDeclaration:
    PUBLIC type IDENTIFIER parameters '{' CompoundStatement RETURN expression ';' '}'

parameters:
    '(' paramList ')'
    |  '(' ')'
    ;

paramList:
    type IDENTIFIER
    | type IDENTIFIER ',' paramList
    ;

CompoundDeclaration:
    CompoundDeclaration declaration 
    | /* empty */
    ;

CompoundStatement:
    CompoundStatement statement
    | /* empty */
    ;

statement :
    '{' CompoundStatement '}'
	| 	print_smt
	| 	assignment
    |   declaration
	| 	access
	| 	if_block
	| 	do_while_block
	| 	while_block
    |   IDENTIFIER '(' CompoundExpression ')' ';'
    ;

CompoundExpression:
    expression ExpressionList 
    | /* empty */
    ;

ExpressionList:
    ExpressionList ',' expression 
    | /* empty */
    ;

print_smt:
    PRINT '(' expression ')' ';'

assignment:
    IDENTIFIER '=' expression ';'
    ;

declaration:
    type IDENTIFIER ';'
    ;

access:
    IDENTIFIER '[' expression ']' '=' expression ';'
    ;

if_block:
    IF '(' expression ')' statement %prec LOWER_THAN_ELSE
    | IF '(' expression ')' statement ELSE statement
    ;

do_while_block:
    DO statement WHILE '(' expression ')' ';'
    ;

while_block:
    WHILE '(' expression ')' statement
    ;

expression:
    PrimaryExpression '&' '&' PrimaryExpression
	| 	PrimaryExpression '|' '|' PrimaryExpression
	| 	PrimaryExpression '!' '=' PrimaryExpression
	| 	PrimaryExpression '<' '=' PrimaryExpression
	| 	PrimaryExpression '+' PrimaryExpression
	| 	PrimaryExpression '-' PrimaryExpression
	| 	PrimaryExpression '*' PrimaryExpression
	| 	PrimaryExpression '/' PrimaryExpression
	| 	PrimaryExpression '[' PrimaryExpression ']'
	| 	PrimaryExpression '.' LENGTH
	| 	PrimaryExpression
	| 	PrimaryExpression '.' IDENTIFIER '(' CompoundExpression ')'
	| 	IDENTIFIER '(' CompoundExpression ')'
	| 	'(' IDENTIFIER ')' '-' '>' expression
    ;

PrimaryExpression:
    NUMBER
	| 	TRUE
	| 	FALSE
	| 	IDENTIFIER                
	| 	THIS
	| 	NEW INT '[' expression ']'
	| 	NEW IDENTIFIER '(' ')'
	| 	'!' expression
	| 	'(' expression ')'
    ; 

MacroDefinition:
    MacroDefExpression
    | MacroDefStatement
    ;

MacroDefStatement:
    DEFINE IDENTIFIER '(' CompoundIdentifierList ')' '{' statement '}'
    ;
    
MacroDefExpression:
    DEFINE IDENTIFIER '(' CompoundIdentifierList ')' '(' expression ')'
    ;

CompoundIdentifierList:
    IDENTIFIER IdentifierList
    |  /* empty */
    ;

IdentifierList:
    /* empty */
    | IdentifierList ',' IDENTIFIER 
    ;

type:
    int | boolean | arraytype | userType | lambda
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

userType:
    IDENTIFIER
    ;

lambda:
    IDENTIFIER '<' IDENTIFIER ',' IDENTIFIER '>' 
%%

void yyerror(char *s) {
    fprintf(stderr, "%d\n", line_counter);
    exit(1);
}

int main(int argc, char** argv) {
    yydebug = 1;
    return yyparse();
}