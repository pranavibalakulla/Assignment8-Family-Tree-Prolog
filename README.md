# Assignment 8: Family Tree in Prolog

A Prolog program that represents a three-generation family and uses rules, logical inference, and recursion to answer questions about family relationships.

## Files

| File | Description |
|---|---|
| `family_tree.pl` | Facts (`parent`, `male`, `female`) and rules (`father`, `mother`, `child`, `grandparent`, `sibling`, `cousin`, recursive `descendant` and `ancestor`, plus list helpers) |

## Family modeled

```
john + susan
├── mary ──────────── sophia, james
└── michael + linda ─ david, emma
```

## How to run

1. Install [SWI-Prolog](https://www.swi-prolog.org/).
2. Open SWI-Prolog in this folder and load the program:
   ```prolog
   ?- consult('family_tree.pl').
   ```
3. Run any query below. Press `;` to see the next answer; Prolog prints `false.` when no more answers remain.

## Sample queries and expected output

| Question | Query | Expected output |
|---|---|---|
| Who are John's children? | `child(X, john).` | `X = mary ; X = michael.` |
| Who are Mary's siblings? | `sibling(mary, X).` | `X = michael ; false.` |
| Is David a cousin of Sophia? | `cousin(david, sophia).` | `true.` |
| Is Mary a cousin of David? | `cousin(mary, david).` | `false.` |
| Who are David's cousins? | `cousin(david, X).` | `X = sophia ; X = james ; false.` |
| Who are John's grandchildren? | `grandparent(john, X).` | `X = sophia ; X = james ; X = david ; X = emma.` |
| Who is Mary's father? | `father(F, mary).` | `F = john ; false.` |
| All of John's descendants (recursive) | `descendant(X, john).` | `mary, michael, david, emma, sophia, james`, then `false.` |
| Is Sophia a descendant of John? | `descendant(sophia, john).` | `true.` |
| Sophia's ancestors (recursive) | `ancestor(X, sophia).` | `X = mary ; X = john ; X = susan ; false.` |

### List helpers (all answers at once, no duplicates)

```prolog
?- children_of(john, L).     % L = [mary, michael].
?- siblings_of(mary, L).     % L = [michael].
?- cousins_of(david, L).     % L = [james, sophia].
?- descendants_of(john, L).  % L = [david, emma, james, mary, michael, sophia].
```

## How the recursion works

```prolog
descendant(X, Y) :- parent(Y, X).                     % base case: X is Y's child
descendant(X, Y) :- parent(Z, X), descendant(Z, Y).   % recursive case: X's parent descends from Y
```

The base case finds direct children. The recursive case moves up one generation at a time until it reaches `Y`, so the rule works for any number of generations.
