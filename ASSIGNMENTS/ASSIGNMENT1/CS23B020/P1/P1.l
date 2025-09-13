%{
    #include <bits/stdc++.h>
    #include "P1.tab.h"
    void yyerror(char *);
    using namespace std;
%}


%%

"int"           { return INT; }
"boolean"       { return BOOLEAN; }
"int[]"         { return ARRAYTYPE; }
"void"          { return VOID; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"return"        { return RETURN; }
"true"          { return TRUE; }
"false"         { return FALSE; }
"this"          { return THIS; }
"new"           { return NEW; }
"do"            { return DO; }
"class"         { return CLASS; }
"System.out.println" { return PRINT; }
"static"        { return STATIC; }
"public"        { return PUBLIC; }
"extends"       { return EXTENDS; }
"String"        { return STRING; }
"#define"       { return DEFINE; }
"main"          { return MAIN; }
"length"        { return LENGTH; }
"import"        { return IMPORT; }
"java.util.function.Function"    { return HEADER; }
"Function"      { return FUNCTION; }

[)][ \n\t]*[-][>] { return ARROW; }

"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
"*"             { return '*'; }
"/"             { return '/'; }
"+"             { return '+'; }
"-"             { return '-'; }
"!"            { return '!'; }
","             { return ','; }
"&"            { return '&'; }
"."             { return '.'; }
"["             { return '['; }
"]"             { return ']'; }
">"             { return '>'; }
"<"             { return '<'; }
"|"            { return '|'; }
"="             { return '='; }
";"             { return ';'; }

[0-9]+\.[0-9]+  { yylval.val=strdup(yytext); return NUMBER;}
[0-9]+          { yylval.val=strdup(yytext); return NUMBER;}

[a-zA-Z_][a-zA-Z0-9_]* { yylval.val=strdup(yytext); return IDENTIFIER;}

[ \t]           { /* ignore whitespace */ }

"//".*            { /* ignore everything until end of line */ }
"\n"            { }
.               { }

%%

int yywrap(void) {
    return 1;
}



