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
    map<string, int> values;
%}

%union {
    char* val;
    int valid;
}

%token <val> IDENTIFIER NUMBER STRING
%token PRINTF  
%type <valid> expression

%left '+' '-' 
%left '*' '/'
%right EXP

%%

program:
    program compound_stmt
    | /* empty */
    
    ;


compound_stmt:
    statement
    ;

statement:

    expression ';' { cout<< $1 <<endl; }
    | assignment ';'
    | print_statement ';';

print_statement:
    PRINTF IDENTIFIER { cout<< values[$2] <<endl ; }

 //need to check if the variable is an array or not
assignment:
    IDENTIFIER '=' expression { values[$1] = $3 ;}
    ;

expression:
    '(' expression ')' {$$ = $2;}
    | expression '+' expression {$$ = $1 + $3;}
    | expression '-' expression {$$ = $1 - $3;}
    | expression '*' expression {$$ = $1 * $3;}
    | expression '/' expression {$$ = $1 / $3;}
    | expression EXP expression {$$ = pow($1, $3);}
    | IDENTIFIER {$$ = values[$1];}
    | NUMBER {$$ = stoi($1);}
    | '-' expression {$$ = -1 * $2;}
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%d\n", line_counter);
    exit(1);
}

int main(void) {
    return yyparse();
}