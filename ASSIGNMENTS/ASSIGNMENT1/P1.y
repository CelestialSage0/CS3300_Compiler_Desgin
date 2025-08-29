%{
  /* CS22B059. CS23B004, CS23B012, CS23B020 */
    #include <bits/stdc++.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    using namespace std;
    void yyerror(char *);
    int yylex(void);
    int line_counter = 1;

    string indent(const string &inp) {
        string res = "";

        for (char c : inp) {
            if (c == '\n') res = res + "\n    ";
            else res = res + c;
        }
        return res;
    }
%}

%union {
    char* val;
    int indent;
}

%token <val> IDENTIFIER NUMBER
%type <val> int char float void type
%token INT CHAR FLOAT VOID IF ELSE WHILE RETURN  
%type <val> statements statement expression assignment return_stmt if_else_block while_block declaration 

%left '+' '-' 
%left '*' '/'

%%

program:
    program function
    | /* empty */
    ;

function:
    type IDENTIFIER '(' ')' '{' statements '}' { cout << $1 << ' ' << $2 << "() {\t" << indent(string($6)) << "\n}\n" ; }
    ;

type:
    int | char | float | void { $$ = $1; }
    ;

int:
   INT { $$ = "int"; }
   ;

float:
   FLOAT { $$ = "float"; }
   ;

char:
   CHAR { $$ = "char"; }
   ;

void:
   VOID { $$ = "void"; }
   ;


statements:
    statements statement { $$ = strdup(string(string($1) + "\n" + string($2)).data()); }
    | { $$ = ""; }
    ;

statement:
    expression ';' { $$ = string(string($1) + ";").data(); } 
    | declaration ';' { $$ = strdup(string(string($1) + ";").data()); }  
    | assignment ';' { $$ = strdup(strdup(string(string($1) + ";").data())); }  
    | return_stmt ';' { $$ = strdup(string(string($1) + ";").data()); } 
    | if_else_block { $$ = $1; }
    | while_block { $$ = $1; }
    ;

assignment:
    IDENTIFIER '=' expression { $$ = strdup(string( string($1) + " = " + string($3) ).data()); }
    ;

declaration:
    type IDENTIFIER { $$ = strdup(string( string($1) + " " + string($2) ).data()); }
    ;

return_stmt:
    RETURN expression { $$ = strdup(string( "return " + string($2)).data()); }
    ;

if_else_block:
    IF '(' expression ')' '{' statements '}' ELSE '{' statements '}' { $$ = strdup(string( "if (" + string($3) + ") {" + indent(string($6)) + "\n} else {" + indent(string($10)) + "\n}").data()); }
    ;

while_block:
    WHILE '(' expression ')' '{' statements '}' { $$ = strdup(string("while (" + string($3) + ") {" + indent(string($6)) + "\n}").data()); }

expression:
    '(' expression ')' { $$ = strdup(string( "(" + string($2) + ")" ).data()); }
    | expression '+' expression { $$ = strdup(string( string($1) + " + " + string($3) ).data()); } 
    | expression '-' expression { $$ = strdup(string( string($1) + " - " + string($3) ).data()); } 
    | expression '*' expression { $$ = strdup(string( string($1) + " * " + string($3) ).data()); } 
    | expression '/' expression { $$ = strdup(string( string($1) + " / " + string($3) ).data()); } 
    | IDENTIFIER { $$ = $1; }
    | NUMBER { $$ = $1; }
    | '-' expression  { $$ = strdup(string( "-" + string($2) ).data()); } 
    | IDENTIFIER '(' ')'  { $$ = strdup(string( string($1) + "(" + ")" ).data()); } 
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%d\n", line_counter);
    exit(1);
}

int main(int argc, char** argv) {
    return yyparse();
}