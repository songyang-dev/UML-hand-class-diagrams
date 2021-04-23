%{
#include <stdio.h>
#include <stdlib.h>

#include "tree.h"

extern int yylineno;
extern YUML* root;

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
    YUML* yuml;
    Line* line;
    Box* box;
    Connection* connection;
    Description* description;
    DashType dashType;
    Annotation* annotation;
    End end;
    Multiplicity* multiplicity;
    Access access;
    Section* section;
    Args* args;
}

%token <int_val> tINTVAL
%token <string_val> tSTRING
%token tINTERFACEOPEN tINTERFACECLOSE tAGGREGATION tCOMPOSITION tLEFTARROW tRIGHTARROW tDOTLINE

%left '-' tDOTLINE

%type <yuml> program program_line
%type <line> line
%type <box> box umlClass
%type <connection> connection
%type <description> umlClassDescription
%type <string_val> boxName
%type <dashType> dashType
%type <annotation> annotation dashAnnotationLeft dashAnnotationRight
%type <end> end
%type <multiplicity> multiplicity
%type <string_val> stringSequence
%type <access> access
%type <section> section
%type <args> args

%start program

%%

program: program_line      {root = $1;}
    ;

program_line: line           {$$ = makeYUML($1);}
    |   line program_line    {$$ = linkYUML(makeYUML($1), $2);}
    ;
    
line: box                   {$$ = makeLine_box($1);}
    |   box connection line {$$ = connectBoxOnLine(makeLine_box($1), $2, $3);}
    ;

box: '[' umlClass ']'   {$$ = $2;}
    ;

umlClass: boxName       {$$ = makeBox($1);}
    |   boxName '|' umlClassDescription {$$ = makeBox_description($1, $3);}
    ;

connection: dashAnnotationLeft dashType dashAnnotationRight    {$$ = makeConnection($1, $2, $3);}
    ;

boxName: tSTRING    {$$ = $1;}
    |   tINTERFACEOPEN tSTRING tINTERFACECLOSE ';' tSTRING  {$$ = combineBoxName($2, $5);}
    |   tINTERFACEOPEN tSTRING tINTERFACECLOSE  {$$ = combineBoxName_interfaceOnly($2);}
    ;

dashType: '-'   {$$ = Simple;}
    |   '-' '-' {$$ = Double;}
    |   tDOTLINE    {$$ = DotLine;}
    |   '^' '-'    {$$ = Inheritance;}
    |   '^'    {$$ = Inheritance;}
    |   '^' tDOTLINE    {$$ = InheritanceDotted;}
    ;

dashAnnotationLeft: annotation  {$$ = $1;}
    |   end annotation {$$ = linkAnnotation_leftEnd($2, $1);}
    |   end {$$ = makeAnnotation_endOnly($1);}
    |   {$$ = NULL;}
    ;

dashAnnotationRight: annotation  {$$ = $1;}
    |   annotation end    {$$ = linkAnnotation_rightEnd($1, $2);}
    |   end {$$ = makeAnnotation_endOnly($1);}
    |   {$$ = NULL;}
    ;

annotation: stringSequence  {$$ = makeAnnotation_string($1);}
    |   multiplicity    {$$ = makeAnnotation_mult($1);}
    |   stringSequence multiplicity {$$ = makeAnnotation_both($1, $2);}
    ;

multiplicity:   tINTVAL '.' '.' '*'     {$$ = makeMultiplicity(LowerBounded, $1, -1);}
    |   tINTVAL '.' '.' tINTVAL {$$ = makeMultiplicity(Bounded, $1, $4);}
    |   tINTVAL                 {$$ = makeMultiplicity(Fixed, $1, -1);}
    |   '*'                     {$$ = makeMultiplicity(Infinite, -1, -1);}
    ;

end: tAGGREGATION   {$$ = Aggregation;}
    |   '+'         {$$ = Aggregation;}
    |   tCOMPOSITION    {$$ = Composition;}
    // |   '^'    {printf("Entering end\n");}
    |   tLEFTARROW  {$$ = LeftArrow;}
    |   tRIGHTARROW {$$ = RightArrow;}
    ;

umlClassDescription: section {$$ = makeDescription($1);}
    |   section '|' umlClassDescription {$$ = linkDescription(makeDescription($1), $3);}
    ;

section: access tSTRING {$$ = makeSection(Field, $1, $2, NULL);}
    |   access tSTRING '(' args ')'  {$$ = makeSection(Method, $1, $2, $4);}
    |   access tSTRING ';' section  {$$ = linkSection(makeSection(Field, $1, $2, NULL), $4);}
    |   access tSTRING '(' args ')' ';' section  {$$ = linkSection(makeSection(Method, $1, $2, $4), $7);}
    |   access tSTRING '(' ')' ';' section  {$$ = linkSection(makeSection(Method, $1, $2, NULL), $6);}
    |   access tSTRING '(' ')'  {$$ = makeSection(Method, $1, $2, NULL);}
    ;

access: '+' {$$ = Public;}
    |   '-' {$$ = Private;}
    |   '#' {$$ = Protected;}
    |       {$$ = None;}
    ;

args: tSTRING   {$$ = makeArgs($1);}
    |   tSTRING ',' args    {$$ = linkArgs(makeArgs($1), $3);}
    ;

stringSequence: tSTRING {$$ = $1;}
    |   tSTRING stringSequence  {$$ = combineStringSequence($1, $2);}
    ;

%%