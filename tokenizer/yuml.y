%{
#include <stdio.h>
#include <stdlib.h>

#include "tree.h"

extern int yylineno;
//extern EXP *root;

int yylex();
void yyerror(const char *s) { fprintf(stderr, "Error: (line %d) %s\n", yylineno, s); exit(1); }
%}

%locations
%error-verbose

%code requires
{
	#include "tree.h"
}

%union {
    int int_val;
	char *string_val;
	EXP *exp;
}

%token <int_val> tINTVAL
%token <string_val> tIDENTIFIER tSTRING
%token tINTERFACEOPEN tINTERFACECLOSE tAGGREGATION tCOMPOSITION tINHERITANCE tLEFTARROW tRIGHTARROW tDOTLINE

%left '-' tDOTLINE

%start program

%% 
program: line           {printf("Entering program: line\n");}
    |   line program    {printf("Entering program: line program\n");}
    ;

line: box                   {printf("Entering line: box\n");}
    |   box connection line {printf("Entering line: box connection line\n");}
    ;

box: '[' umlClass ']'   {printf("Entering box: umlClass\n");}
    ;

umlClass: boxName       {printf("Entering uml class: boxName\n");}
    |   boxName '|' umlClassDescription {printf("Entering uml class: boxName | umlClassDescription\n");}
    ;

connection: dashAnnotationLeft dashType dashAnnotationRight    {printf("Entering connection: dashType and annotations\n");}
    ;

boxName: tIDENTIFIER    {printf("Entering box name\n");}
    |   tINTERFACEOPEN tIDENTIFIER tINTERFACECLOSE ';' tIDENTIFIER  {printf("Entering box name\n");}
    ;

dashType: '-'   {printf("Entering dash type\n");}
    |   tDOTLINE    {printf("Entering dash type\n");}
    ;

dashAnnotationLeft: annotation  {printf("Entering dash annotation left\n");}
    |   end annotation {printf("Entering dash annotation left: end annotation\n");}
    |   end {printf("Entering dash annotation left: end\n");}
    |
    ;

dashAnnotationRight: annotation  {printf("Entering dash annotation right\n");}
    |   annotation end    {printf("Entering dash annotation right: annotation end\n");}
    |   end {printf("Entering dash annotation right: end\n");}
    |
    ;

annotation: stringSequence      {printf("Entering annotation: string sequence\n");}
    |   tINTVAL '.' '.' '*'     {printf("Entering annotation: multiplicity\n");}
    |   tINTVAL '.' '.' tINTVAL {printf("Entering annotation: multiplicity\n");}
    |   tINTVAL                 {printf("Entering annotation: multiplicity\n");}
    ;

end: tAGGREGATION   {printf("Entering end\n");}
    |   '+'         {printf("Entering end\n");}
    |   tCOMPOSITION    {printf("Entering end\n");}
    |   tINHERITANCE    {printf("Entering end\n");}
    |   tLEFTARROW  {printf("Entering end\n");}
    |   tRIGHTARROW {printf("Entering end\n");}
    ;

umlClassDescription: section {printf("Entering uml class description\n");}
    |   section '|' umlClassDescription {printf("Entering uml class description: tSTRING | next\n");}
    ;

section: access tIDENTIFIER {printf("Entering section: field\n");}
    |   access tIDENTIFIER '(' ')'  {printf("Entering section: method\n");}
    |   access tIDENTIFIER ';' section  {printf("Entering section: field next\n");}
    |   access tIDENTIFIER '(' ')' ';' section  {printf("Entering section: method next\n");}
    ;

access: '+' {printf("Entering access\n");}
    |   '-' {printf("Entering access\n");}
    |   '#' {printf("Entering access\n");}
    |       {printf("Entering access\n");}
    ;

stringSequence: tSTRING {printf("Entering string sequence\n");}
    |   tSTRING stringSequence  {printf("Entering string sequence: next\n");}
    ;

%%