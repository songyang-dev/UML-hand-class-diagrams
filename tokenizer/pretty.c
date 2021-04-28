#include "pretty.h"

#include <stdio.h>

void printLine(Line *);
void printBox(Box *box);
void printConnection(Connection *c);
void printDescription(Description *d);
void printAnnotation(Side s, Annotation *a);
void printEnd(End e);
void printMultiplicity(Multiplicity *m);
void printDescription(Description *d);
void printSection(Section *s);
void printAccess(Access a);
void printArgs(Args *a);

void printYUML(YUML *y)
{
    printLine(y->current);
    printf("\n");
    if (y->next != NULL)
        printYUML(y->next);
}

void printLine(Line *line)
{
    printBox(line->box);
    if (line->next != NULL)
    {
        printLine(line->next);
    }
}

void printBox(Box *box)
{
    printf("[ ");
    printf(box->name);
    printf(" ");
    if (box->description != NULL)
    {
        printf("| ");
        printDescription(box->description);
    }
    printf("] ");

    if (box->connects != NULL)
        printConnection(box->connects);
}

void printConnection(Connection *c)
{
    if (c->left != NULL)
        printAnnotation(Left, c->left);
    switch (c->dashtype)
    {
    case Simple:
    case Double:
        printf("- ");
        break;

    case DotLine:
        printf("-.- ");
        break;

    case Inheritance:
        printf("^ ");
        break;

    case InheritanceDotted:
        printf("^-.- ");
        break;
    }
    if (c->right != NULL)
        printAnnotation(Right, c->right);
}

void printAnnotation(Side s, Annotation *a)
{
    if (a->isEndOnly)
    {
        printEnd(a->end);
    }
    else
    {
        switch (s)
        {
        case Left:
            printEnd(a->end);
            if (a->stringSequence != NULL)
                printf("%s ", a->stringSequence);
            if (a->multiplicity != NULL)
                printMultiplicity(a->multiplicity);
            break;

        case Right:
            if (a->stringSequence != NULL)
                printf("%s ", a->stringSequence);
            if (a->multiplicity != NULL)
                printMultiplicity(a->multiplicity);
            printEnd(a->end);
            break;
        }
    }
}

void printEnd(End e)
{
    switch (e)
    {
    case Aggregation:
        printf("<> ");
        break;
    case Composition:
        printf("++ ");
        break;
    case LeftArrow:
        printf("< ");
        break;
    case RightArrow:
        printf("> ");
        break;

    default:
        fprintf(stderr, "Unknown End\n");
        break;
    }
}

void printMultiplicity(Multiplicity *m)
{
    switch (m->kind)
    {
    case LowerBounded:
        printf("%i .. * ", m->base);
        break;
    case Bounded:
        printf("%i .. %i", m->base, m->secondary);
        break;
    case Fixed:
        printf("%i ", m->base);
        break;
    case Infinite:
        printf("* ");
        break;
    default:
        break;
    }
}

void printDescription(Description *d)
{
    printSection(d->section);
    if (d->next != NULL)
    {
        printf("| ");
        printDescription(d->next);
    }
}

void printSection(Section *s)
{
    printAccess(s->access);
    printf("%s ", s->text);

    switch (s->kind)
    {
    case Field:
        break;
    case Method:
        printf("( ");
        if (s->args != NULL)
            printArgs(s->args);
        printf(") ");
        break;

    default:
        fprintf(stderr, "Unknown section kind\n");
        break;
    }

    if (s->next != NULL)
    {
        printf("; ");
        printSection(s->next);
    }
}

void printAccess(Access a)
{
    switch (a)
    {
    case Public:
        printf("+ ");
        break;
    case Private:
        printf("- ");
        break;
    case Protected:
        printf("# ");
        break;
    case None:
        break;

    default:
        fprintf(stderr, "Unknown access modifier\n");
        break;
    }
}

void printArgs(Args *a)
{
    printf("%s ", a->name);
    if (a->next != NULL)
    {
        printf(", ");
        printArgs(a->next);
    }
}