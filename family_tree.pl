% Assignment 8 - Family Tree in Prolog

% Basic family relationships
parent(john, mary).
parent(john, michael).
parent(susan, mary).
parent(susan, michael).

parent(michael, david).
parent(michael, emma).
parent(linda, david).
parent(linda, emma).

parent(mary, sophia).
parent(mary, james).

% Gender facts
male(john).
male(michael).
male(david).
male(james).

female(susan).
female(mary).
female(linda).
female(emma).
female(sophia).

% Grandparent relationship
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

% Sibling relationship
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% Cousin relationship
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y.

% Direct child relationship
child(X, Y) :-
    parent(Y, X).

% Recursive descendant relationship
descendant(X, Y) :-
    parent(Y, X).

descendant(X, Y) :-
    parent(Z, X),
    descendant(Z, Y).