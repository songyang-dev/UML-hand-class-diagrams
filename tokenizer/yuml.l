%{
#include <stdio.h>
#include <string.h>

#include "parser.tab.h"
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
%}

%option yylineno
%option noinput
%option nounput
%option noyywrap

%%

"[" return '[';
"]" return ']';
"|" return '|';
"<<" return tINTERFACEOPEN;
">>" return tINTERFACECLOSE;
";" return ';';
"-" return '-';
"-.-" return tDOTLINE;
"<>" return tAGGREGATION;
"+" return '+';
"++" return tCOMPOSITION;
"^" return tINHERITANCE;
"<" return tLEFTARROW;
">" return tRIGHTARROW;
"(" return '(';
")" return ')';
"#" return '#';
"." return '.';
"*" return '*';

[0-9]|[1-9][0-9]* {
    yylval.int_val = atoi(yytext);
    return tINTVAL;
}

[a-zA-Z_][a-zA-Z0-9_]* { 
	yylval.string_val = strdup(yytext);
	return tIDENTIFIER;
}

[a-zA-Z0-9_()]* {
    yylval.string_val = strdup(yytext);
	return tSTRING;
}

[ \t\n\r]+

.       { fprintf(stderr, "Error: (line %d) unexpected character '%s'\n", yylineno, yytext); exit(1); }

%%