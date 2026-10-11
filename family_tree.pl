% Assignment 8 - Family Tree in Prolog
% Load in SWI-Prolog with:  ?- consult('family_tree.pl').

% ---------------------------------------------------------------
% Basic family relationships (facts)
% parent(Parent, Child)
% ---------------------------------------------------------------
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

% ---------------------------------------------------------------
% Derived relationships (rules)
% ---------------------------------------------------------------

% Father and mother: combine parent facts with gender facts
father(F, C) :-
    parent(F, C),
    male(F).

mother(M, C) :-
    parent(M, C),
    female(M).

% Direct child relationship: X is a child of Y
child(X, Y) :-
    parent(Y, X).

% Grandparent: X is a grandparent of Y (parent of a parent)
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

% Sibling: X and Y share the same parent.
% distinct/2 stops the same pair from being returned twice when
% the siblings share both parents (e.g., mary and michael).
sibling(X, Y) :-
    distinct(X-Y, ( parent(P, X),
                    parent(P, Y),
                    X \= Y )).

% Cousin: X and Y have parents who are siblings
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y.

% ---------------------------------------------------------------
% Recursive relationships
% ---------------------------------------------------------------

% descendant(X, Y): X is a descendant of Y
descendant(X, Y) :-                 % base case: X is a child of Y
    parent(Y, X).
descendant(X, Y) :-                 % recursive case: X's parent is a
    parent(Z, X),                   % descendant of Y
    descendant(Z, Y).

% ancestor(X, Y): X is an ancestor of Y (inverse of descendant)
ancestor(X, Y) :-
    descendant(Y, X).

% ---------------------------------------------------------------
% Query helpers: collect every answer into one sorted list
% ---------------------------------------------------------------
children_of(Person, List)    :- setof(C, child(C, Person), List).
siblings_of(Person, List)    :- setof(S, sibling(Person, S), List).
cousins_of(Person, List)     :- setof(C, cousin(Person, C), List).
descendants_of(Person, List) :- setof(D, descendant(D, Person), List).
