#ifndef TREE_H
#define TREE_H

#include <stdbool.h>

typedef struct YUML YUML;
typedef struct Line Line;
typedef struct Box Box;
typedef struct Connection Connection;
typedef struct Description Description;
typedef struct Annotation Annotation;
typedef struct Multiplicity Multiplicity;
typedef struct Section Section;
typedef struct Args Args;

typedef enum {
    Simple,
    Double,
    DotLine,
    Inheritance,
    InheritanceDotted
} DashType;

typedef enum {
    Aggregation,
    Composition,
    LeftArrow,
    RightArrow,
    NoEnd
} End;

typedef enum {
    Left, Right
} Side;

typedef enum {
    LowerBounded,
    Bounded,
    Fixed,
    Infinite
} MultiplicityKind;


typedef enum {
    Private, Public, Protected, None
} Access;

typedef enum {
    Field,
    Method
} SectionKind;

struct YUML {
    Line* current;
    YUML* next;
};

struct Line {
    int lineno;
    Line* next;
    Box* box;
};

struct Box {
    char* name;
    Connection* connects;
    Description* description;
};

struct Connection {
    Annotation* left;
    Annotation* right;
    DashType dashtype;
};

struct Description {
    Section* section;
    Description* next;
};

struct Annotation {
    End end;
    char* stringSequence;
    Multiplicity* multiplicity;
    bool isEndOnly;
    Side side;
};

struct Multiplicity {
    int base;
    int secondary;
    MultiplicityKind kind;
};

struct Section {
    SectionKind kind;
    Access access;
    char* text;
    Args* args;
    Section* next;
};

struct Args {
    char* name;
    Args* next;
};

YUML* makeYUML(Line*);
YUML* linkYUML(YUML*, YUML*);

Line* makeLine_box(Box*);
Line* connectBoxOnLine(Line* currentLineOfBox, Connection*, Line* nextLine);

Box* makeBox(char* name);
Box* makeBox_description(char* name, Description*);

Connection* makeConnection(Annotation* left, DashType, Annotation* right);

char* combineBoxName(char* interfaceName, char* boxName);
char* combineBoxName_interfaceOnly(char* interfaceName);

Annotation* makeAnnotation_string(char*);
Annotation* makeAnnotation_mult(Multiplicity*);
Annotation* makeAnnotation_both(char*, Multiplicity*);
Annotation* linkAnnotation_leftEnd(Annotation*, End);
Annotation* linkAnnotation_rightEnd(Annotation*, End);
Annotation* makeAnnotation_endOnly(End);

Multiplicity* makeMultiplicity(MultiplicityKind kind, int base, int secondary);

Description* makeDescription(Section* section);
Description* linkDescription(Description* root, Description* next);

Section* makeSection(SectionKind, Access, char* text, Args*);
Section* linkSection(Section* current, Section* next);

Args* makeArgs(char*);
Args* linkArgs(Args* current, Args* next);

char* combineStringSequence(char* oneString, char* other);

#endif