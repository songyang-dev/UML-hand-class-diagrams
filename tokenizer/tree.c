#include "tree.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int yylineno;

YUML* makeYUML(Line* l)
{
    YUML* y = (YUML*)malloc(sizeof(YUML));
    y->current = l;
    y->next = NULL;
    return y;
}

YUML* linkYUML(YUML* current, YUML* next)
{
    current->next = next;
    return current;
}

Line* makeLine_box(Box* box)
{
    Line* l = (Line *)malloc(sizeof(Line));
    l->lineno = yylineno;
    l->box = box;
    l->next = NULL;
    return l;
}

Line* connectBoxOnLine(Line* currentLineOfBox, Connection* connects, Line* nextLine)
{
    currentLineOfBox->box->connects = connects;
    currentLineOfBox->next = nextLine;
    return currentLineOfBox;
}

Box* makeBox(char* name)
{
    Box* b = (Box *)malloc(sizeof(Box));
    b->name = name;
    b->description = NULL;
    b->connects = NULL;
    return b;
}

Box* makeBox_description(char* name, Description* description)
{
    Box* b = makeBox(name);
    b->description = description;
    return b;
}

Connection* makeConnection(Annotation* left, DashType dash, Annotation* right)
{
    Connection* c = (Connection *)malloc(sizeof(Connection));
    c->dashtype = dash;
    c->left = left;
    c->right = right;
    return c;
}

char* combineBoxName(char* interfaceName, char* boxName)
{
    char* combined = (char*)malloc(
        sizeof(char) * (20 + strlen(interfaceName) + strlen(boxName))
        );
    sprintf(combined, "<< %s >> ; %s", interfaceName, boxName);
    return combined;
}

char* combineBoxName_interfaceOnly(char* interfaceName)
{
    char* combined = (char*)malloc(
        sizeof(char) * (20 + strlen(interfaceName))
        );
    sprintf(combined, "<< %s >>", interfaceName);
    return combined;
}

Annotation* makeAnnotation_string(char* stringSequence)
{
    Annotation* a = (Annotation*)malloc(sizeof(Annotation));
    a->stringSequence = stringSequence;
    a->multiplicity = NULL;
    a->isEndOnly = false;
    a->end = NoEnd;
    return a;
}

Annotation* makeAnnotation_mult(Multiplicity* mult)
{
    Annotation* a = (Annotation*)malloc(sizeof(Annotation));
    a->multiplicity = mult;
    a->stringSequence = NULL;
    a->isEndOnly = false;
    a->end = NoEnd;
    return a;
}

Annotation* makeAnnotation_both(char* stringSequence, Multiplicity* mult)
{
    Annotation* a = (Annotation*)malloc(sizeof(Annotation));
    a->stringSequence = stringSequence;
    a->multiplicity = mult;
    a->isEndOnly = false;
    a->end = NoEnd;
    return a;
}

Annotation* linkAnnotation_leftEnd(Annotation* annotation, End end)
{
    annotation->end = end;
    annotation->side = Left;
    return annotation;
}

Annotation* linkAnnotation_rightEnd(Annotation* annotation, End end)
{
    annotation->end = end;
    annotation->side = Right;
    return annotation;
}

Annotation* makeAnnotation_endOnly(End end)
{
    Annotation* a = (Annotation*)malloc(sizeof(Annotation));
    a->end = end;
    a->isEndOnly = true;
    return a;
}

Multiplicity* makeMultiplicity(MultiplicityKind kind, int base, int secondary)
{
    Multiplicity* m = (Multiplicity*)malloc(sizeof(Multiplicity));
    m->kind = kind;
    m->base = base;
    m->secondary = secondary;
    return m;
}

Description* makeDescription(Section* section)
{
    Description* d = (Description*)malloc(sizeof(Description));
    d->section = section;
    d->next = NULL;
    return d;
}

Description* linkDescription(Description* root, Description* next)
{
    root->next = next;
    return root;
}

Section* makeSection(SectionKind kind, Access access, char* text, Args* args)
{
    Section* s = (Section*)malloc(sizeof(Section));

    s->kind = kind;
    s->access = access;
    s->text = text;
    s->args = args;
    s->next = NULL;

    return s;
}

Section* linkSection(Section* current, Section* next)
{
    current->next = next;
    return current;
}

Args* makeArgs(char* name)
{
    Args* a = (Args*)malloc(sizeof(Args));
    a->name = name;
    a->next = NULL;
    return a;
}

Args* linkArgs(Args* current, Args* next)
{
    current->next = next;
    return current;
}

char* combineStringSequence(char* oneString, char* other)
{
    char* combined = (char*)malloc(
        sizeof(char) * (5 + strlen(oneString) + strlen(other))
        );
    sprintf(combined, "%s %s", oneString, other);
    return combined;
}