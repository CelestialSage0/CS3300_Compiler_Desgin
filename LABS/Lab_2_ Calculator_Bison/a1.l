
%{
  /* CS22B059. CS23B004, CS23B012, CS23B020 */
    #include <bits/stdc++.h>
    #include "y.tab.h"
    void yyerror(char *);
    using namespace std;
%}

%%

"print"         { return PRINTF;}

"("             { return '('; }
")"             { return ')'; }
"^"             { return EXP; }
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




