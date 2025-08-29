%{
    #include <bits/stdc++.h>
    #include "y.tab.h"
    void yyerror(char *);
    using namespace std;
%}

%%

"int"           { return INT; }
"char"          { return CHAR; }
"float"         { return FLOAT; }
"void"          { return VOID; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"return"        { return RETURN; }
"true"          { return TRUE; }
"false"         { return FALSE; }
"this"          {return THIS; }


"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
"*"             { return '*'; }
"/"             { return '/'; }
"+"             { return '+';}
"-"             { return '-'; }

"="             { return '='; }
";"             { return ';'; }

[0-9]+\.[0-9]+  { yylval.val=strdup(yytext); return NUMBER;}
[0-9]+          { yylval.val=strdup(yytext); return NUMBER;}

[a-zA-Z_][a-zA-Z0-9_]* { yylval.val=strdup(yytext); return IDENTIFIER;}

[ \t]           { /* ignore whitespace */ }

"\n"            { }
.               { }

%%

int yywrap(void) {
    return 1;
}



