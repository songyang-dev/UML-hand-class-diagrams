/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_C_INCLUDED
# define YY_YY_PARSER_TAB_C_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 18 "yuml.y" /* yacc.c:1909  */

	#include "tree.h"

#line 48 "parser.tab.c" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tINTVAL = 258,
    tSTRING = 259,
    tINTERFACEOPEN = 260,
    tINTERFACECLOSE = 261,
    tAGGREGATION = 262,
    tCOMPOSITION = 263,
    tLEFTARROW = 264,
    tRIGHTARROW = 265,
    tDOTLINE = 266
  };
#endif
/* Tokens.  */
#define tINTVAL 258
#define tSTRING 259
#define tINTERFACEOPEN 260
#define tINTERFACECLOSE 261
#define tAGGREGATION 262
#define tCOMPOSITION 263
#define tLEFTARROW 264
#define tRIGHTARROW 265
#define tDOTLINE 266

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 22 "yuml.y" /* yacc.c:1909  */

    int int_val;
	char *string_val;
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

#line 98 "parser.tab.c" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_C_INCLUDED  */
