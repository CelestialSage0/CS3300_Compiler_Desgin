%{
    #include <bits/stdc++.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    using namespace std;
    void yyerror(char *);
    int yylex(void);
    struct Macro {
    vector<string> params;
    string body;
    bool expr;
};

map<string, Macro> macros;
    
%}

// %debug

%union {
    char* val;
}

%token <val> IDENTIFIER NUMBER
%type <val> int boolean arraytype type  
%token <val> INT ARROW FUNCTION BOOLEAN ARRAYTYPE IF ELSE WHILE RETURN TRUE FALSE THIS NEW DO PRINT PUBLIC STATIC EXTENDS STRING DEFINE CLASS VOID MAIN LENGTH IMPORT HEADER
%type <val> CompoundStatement statement expression assignment while_block declaration MacroDefinition MacroDefExpression MacroDefStatement
%type <val> program CompoundMacroDefinition MainClass CompoundTypeDeclaration TypeDeclaration CompoundMethodDeclaration MethodDeclaration
%type <val> parameters paramList CompoundDeclaration print_smt access if_block PrimaryExpression
%type <val> CompoundExpression ExpressionList CompoundIdentifierList IdentifierList userType lambda ImportFunction

%%

program:
    ImportFunction CompoundMacroDefinition MainClass CompoundTypeDeclaration {
        string result = string($1) + string($2) + string($3) + string($4);
        cout << result;
        $$ = strdup(result.c_str());
    }
    ;

ImportFunction:
    /* empty */ { $$ = strdup(""); }
    | IMPORT HEADER ';' { $$ = strdup((string("import java.util.function.Function;\n")).c_str()); }
    ;

CompoundMacroDefinition:
    CompoundMacroDefinition MacroDefinition {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    |  /* empty */ { $$ = strdup(""); }
    ;

CompoundTypeDeclaration:
    CompoundTypeDeclaration TypeDeclaration {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    |  /* empty */ { $$ = strdup(""); }
    ;

MainClass:
    CLASS IDENTIFIER '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' IDENTIFIER ')' '{' print_smt '}' '}' {
        string result = "class " + string($2) + " {\npublic static void main(String[] " + string($12) + ") {\n" + string($15) + "}\n}\n";
        $$ = strdup(result.c_str());
    }
    ;

TypeDeclaration:
    CLASS IDENTIFIER '{' CompoundDeclaration CompoundMethodDeclaration '}' {
        string result = "class " + string($2) + " {\n" + string($4) + string($5) + "}\n";
        $$ = strdup(result.c_str());
    }
    | CLASS IDENTIFIER EXTENDS IDENTIFIER '{' CompoundDeclaration CompoundMethodDeclaration '}' {
        string result = "class " + string($2) + " extends " + string($4) + " {\n" + string($6) + string($7) + "}\n";
        $$ = strdup(result.c_str());
    }
    ;

CompoundMethodDeclaration:
    CompoundMethodDeclaration MethodDeclaration {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    |  /* empty */ { $$ = strdup(""); }
    ;

MethodDeclaration:
    PUBLIC type IDENTIFIER parameters '{' CompoundStatement RETURN expression ';' '}' {
        string result = "public " + string($2) + " " + string($3) + string($4) + " {\n" + string($6) + "return " + string($8) + ";\n}\n";
        $$ = strdup(result.c_str());
    }
    ;

parameters:
    '(' paramList ')' {
        string result = "(" + string($2) + ")";
        $$ = strdup(result.c_str());
    }
    |  '(' ')' { $$ = strdup("()"); }
    ;

paramList:
    type IDENTIFIER {
        string result = string($1) + " " + string($2);
        $$ = strdup(result.c_str());
    }
    | type IDENTIFIER ',' paramList {
        string result = string($1) + " " + string($2) + "," + string($4);
        $$ = strdup(result.c_str());
    }
    ;

CompoundDeclaration:
    CompoundDeclaration declaration {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    | /* empty */ { $$ = strdup(""); }
    ;

CompoundStatement:
    CompoundStatement statement {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    | /* empty */ { $$ = strdup(""); }
    ;

statement :
    '{' CompoundStatement '}' {
        string result = "{\n" + string($2) + "}\n";
        $$ = strdup(result.c_str());
    }
    | print_smt { $$ = $1; }
    | assignment { $$ = $1; }
    | declaration { $$ = $1; }
    | access { $$ = $1; }
    | if_block { $$ = $1; }
    | while_block { $$ = $1; }
    | IDENTIFIER '(' CompoundExpression ')' ';' {
        if (macros.find(string($1)) != macros.end()) {
            Macro m = macros[string($1)];
            if(m.expr==0){
            vector<string> args;
            string arglist = string($3);
            stringstream ss(arglist);
            string arg;
            while (getline(ss, arg, ',')) {
                if (!arg.empty()) args.push_back(arg);
            }

            string body = m.body;
            body.pop_back();

            for (int i = 0; i < m.params.size(); i++) {
                regex re("@" + to_string(i) + "@");
                if(isalpha(args[i][0])){
                    body = regex_replace(body, re, args[i]);
                    continue;
                }
                body = regex_replace(body, re, "(" + args[i] + ")");
            }
            $$ = strdup(body.c_str());
            } else yyerror("ERROR");
        } else {
            yyerror("ERROR");
        }
    }
    ;

CompoundExpression:
    expression ExpressionList {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    | /* empty */ { $$ = strdup(""); }
    ;

ExpressionList:
    ExpressionList ',' expression {
        string result = string($1) + "," + string($3);
        $$ = strdup(result.c_str());
    }
    | /* empty */ { $$ = strdup(""); }
    ;

print_smt:
    PRINT '(' expression ')' ';' {
        string result = "System.out.println(" + string($3) + ");\n";
        $$ = strdup(result.c_str());
    }
    ;

assignment:
    IDENTIFIER '=' expression ';' {
        string result = string($1) + " = " + string($3) + ";\n";
        $$ = strdup(result.c_str());
    }
    ;

declaration:
    type IDENTIFIER ';' {
        string result = string($1) + " " + string($2) + ";\n";
        $$ = strdup(result.c_str());
    }
    ;

access:
    IDENTIFIER '[' expression ']' '=' expression ';' {
        string result = string($1) + "[" + string($3) + "] = " + string($6) + ";\n";
        $$ = strdup(result.c_str());
    }
    ;

if_block:
    IF '(' expression ')' statement {
        string result = "if (" + string($3) + ") " + string($5);
        $$ = strdup(result.c_str());
    }
    | IF '(' expression ')' statement ELSE statement {
        string result = "if (" + string($3) + ") " + string($5) + "else " + string($7);
        $$ = strdup(result.c_str());
    }
    ;

// do_while_block:
//     DO statement WHILE '(' expression ')' ';' {
//         string result = "do " + string($2) + "while (" + string($5) + ");\n";
//         $$ = strdup(result.c_str());
//     }
//     ;

while_block:
    WHILE '(' expression ')' statement {
        string result = "while (" + string($3) + ") " + string($5);
        $$ = strdup(result.c_str());
    }
    ;

expression:
    PrimaryExpression '&' '&' PrimaryExpression {
        string result = string($1) + " && " + string($4);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '|' '|' PrimaryExpression {
        string result = string($1) + " || " + string($4);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '!' '=' PrimaryExpression {
        string result = string($1) + " != " + string($4);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '<' '=' PrimaryExpression {
        string result = string($1) + " <= " + string($4);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '+' PrimaryExpression {
        string result = string($1) + " + " + string($3);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '-' PrimaryExpression {
        string result = string($1) + " - " + string($3);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '*' PrimaryExpression {
        string result = string($1) + " * " + string($3);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '/' PrimaryExpression {
        string result = string($1) + " / " + string($3);
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '[' PrimaryExpression ']' {
        string result = string($1) + "[" + string($3) + "]";
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression '.' LENGTH {
        string result = string($1) + ".length";
        $$ = strdup(result.c_str());
    }
    | PrimaryExpression { $$ = $1; }
    | PrimaryExpression '.' IDENTIFIER '(' CompoundExpression ')' {
        string result = string($1) + "." + string($3) + "(" + string($5) + ")";
        $$ = strdup(result.c_str());
    }
    | IDENTIFIER '(' CompoundExpression ')' {
    if (macros.find(string($1)) != macros.end()) {
        Macro m = macros[string($1)];
        if(m.expr == 1){
            vector<string> args;
            string arglist = string($3);
            stringstream ss(arglist);
            string arg;
            while (getline(ss, arg, ',')) {
                if (!arg.empty()) args.push_back(arg);
            }

            string body = m.body;

            for (int i = 0; i < m.params.size(); i++) {
                regex re("@" + to_string(i) + "@");
                if(isalpha(args[i][0])){
                    body = regex_replace(body, re, args[i]);
                    continue;
                }
                body = regex_replace(body, re, "(" + args[i] + ")");
            }

            $$ = strdup((string(body)).c_str());
        } else yyerror("ERROR");
    } else {
        yyerror("ERROR");
    }
    }
    | '(' IDENTIFIER ARROW expression {
        string result = "(" + string($2) + ") -> " + string($4);
        $$ = strdup(string('(' + result + ')').c_str());
    }
    ;

PrimaryExpression:
    NUMBER { $$ = $1; }
    | TRUE { $$ = strdup("true"); }
    | FALSE { $$ = strdup("false"); }
    | IDENTIFIER { $$ = $1; }
    | THIS { $$ = strdup("this"); }
    | NEW INT '[' expression ']' {
        string result = "new int[" + string($4) + "]";
        $$ = strdup(result.c_str());
    }
    | NEW IDENTIFIER '(' ')' {
        string result = "new " + string($2) + "()";
        $$ = strdup(result.c_str());
    }
    | '!' expression {
        string result = "!" + string($2);
        $$ = strdup(result.c_str());
    }
    | '(' expression ')' {
        string result = "(" + string($2) + ")";
        $$ = strdup(result.c_str());
    }
    ;

MacroDefinition:
    MacroDefExpression { $$ = $1; }
    | MacroDefStatement { $$ = $1; }
    ;

MacroDefStatement:
    DEFINE IDENTIFIER '(' CompoundIdentifierList ')' '{' statement '}' {
        string paramList = string($4);
        vector<string> params;
        stringstream ss(paramList);
        string param;
        while (getline(ss, param, ',')) {
            if (!param.empty()) params.push_back(param);
        }

        string body = string($7);

        for (int i = 0; i < params.size(); i++) {
            regex re("\\b" + params[i] + "\\b");
            body = regex_replace(body, re, "@" + to_string(i) + "@");
        }

        Macro m;
        m.params = params;
        m.body = body;
        m.expr = 0;
        macros[string($2)] = m;

        $$ = strdup("");
    }
    ;

MacroDefExpression:
    DEFINE IDENTIFIER '(' CompoundIdentifierList ')' '(' expression ')' {
        string paramList = string($4);
        vector<string> params;
        stringstream ss(paramList);
        string param;
        while (getline(ss, param, ',')) {
            if (!param.empty()) params.push_back(param);
        }

        string body = string($7);

        for (int i = 0; i < params.size(); i++) {
            regex re("\\b" + params[i] + "\\b");
            body = regex_replace(body, re, "@" + to_string(i) + "@");
        }

        Macro m;
        m.params = params;
        m.body = body;
        m.expr = 1;
        macros[string($2)] = m;

        $$ = strdup("");
    }
    ;

CompoundIdentifierList:
    IDENTIFIER IdentifierList {
        string result = string($1) + string($2);
        $$ = strdup(result.c_str());
    }
    |  /* empty */ { $$ = strdup(""); }
    ;

IdentifierList:
    /* empty */ { $$ = strdup(""); }
    | IdentifierList ',' IDENTIFIER {
        string result = string($1) + "," + string($3);
        $$ = strdup(result.c_str());
    }
    ;

type:
    int | boolean | arraytype | userType | lambda { $$ = $1; }
    ;

int:
   INT { $$ = strdup("int"); }
   ;

boolean:
    BOOLEAN { $$ = strdup("boolean"); }
    ;

arraytype:
    ARRAYTYPE { $$ = strdup("int[]"); }
    ;

userType:
    IDENTIFIER { $$ = $1; }
    ;

lambda:
    FUNCTION '<' IDENTIFIER ',' IDENTIFIER '>' {
        string result = "Function <" + string($3) + "," + string($5) + ">";
        $$ = strdup(result.c_str());
    }
    ;

%%

void yyerror(char *s) {
    fprintf(stdout, "// Failed to parse macrojava code.");
    exit(1);
}

int main(int argc, char** argv) {
    return yyparse();
}
