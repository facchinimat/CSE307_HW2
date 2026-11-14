# CSE 307 — Assignment II
**Semantics, Scopes and Type Systems**

**Student:** Matteo Facchini  
**Course:** CSE 307 — Principles of Programming Languages  
**Instructor:** Dr. Ritwik Banerjee  
**University:** Stony Brook University

## Overview

This assignment explores lexical scoping, recursion, higher order functions, structural type equivalence, type coercion and static semantic analysis.

The implementation is divided into 3 parts using OCaml and Python.

## Part I — OCaml Warm Up Problems (30 Points)

**warmup1.ml — Problem 1.1: Scoping Puzzles**

Contains written explanations of lexical scoping, variable bindings, closures and referencing environments. Answers are provided as OCaml comments.

**warmup2.ml — Problem 1.2: Recursive and Polymorphic Operations**

Implements:
- remove_duplicates — Removes duplicate elements while preserving order.
- lookup — Searches an association list environment.
- extend — Adds a binding to an environment.
- eval — Recursively evaluates arithmetic expressions.

**warmup3.ml — Problem 1.3: Closures and Higher Order Functions**

Implements:
- make_counter — Creates independent counters.
- compose and transform — Demonstrate function composition.
- curry and uncurry — Convert between curried and uncurried functions.
- apply_twice — Applies a function twice.

## Part II — Type Equivalence and Coercion (20 Points)

**typesys.py**

Implements:
- is_structurally_equivalent — Checks structural equivalence of primitive, array and record types.
- can_coerce — Implements type coercion, including integer to float promotion, array coercion and record width/depth subtyping.

## Part III — MiniML Semantic Analyzer (50 Points)

**semantics.ml**

Implements:
- check_scope — Checks lexical scope and raises `UnboundVariable` for undeclared variables.
- gen_equations — Generates type constraints for MiniML expressions using fresh type variables.
- unify — Implements unification algorithm, including substitutions, function type decomposition and occurs checks.


## Requirements

- OCaml 4.14.4
- Python 3.10 or newer
- No additional third party libraries required

## Compilation

Compile the OCaml source files:

```bash
ocamlc -c warmup1.ml
ocamlc -c warmup2.ml
ocamlc -c warmup3.ml
ocamlc -c semantics.ml
```

## Testing

The assignment was tested using OCaml 4.14.4 and Python 3.

The main OCaml tests passed all 29 tests.

## Implementation Notes

- The required AST, exceptions and type definitions are kept.
- Problem 1.1 answers are written as comments ( as instructed in assignment details ).
- Unification raises `TypeError` when constraints cannot be satisfied.
