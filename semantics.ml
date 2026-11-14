(* Part 3 - MiniML Semantic Analyzer *)

(* AST from assignment *)
type expr =
  | Var of string
  | Int of int
  | Bool of bool
  | Add of expr * expr
  | If of expr * expr * expr 
  | Let of string * expr * expr
  | Fun of string * expr
  | App of expr * expr

exception UnboundVariable of string
exception TypeError of string

(* Problem 3.1 - Scope and Binding Resolution *)

let rec check_scope ( env : string list ) ( e : expr ) : unit =
  match e with
  | Var x ->
    if not (List.mem x env ) then
      raise (UnboundVariable x )
  | Int _ | Bool _ ->
    ()
  | Add (e1, e2) | App (e1, e2) ->
    check_scope env e1;
    check_scope env e2
  | If (cond, e1, e2) ->
    check_scope env e1;
    check_scope env e2
  | Let (x, e1, e2 ) ->
    check_scope env e1;
    check_scope (x :: env ) e2
  | Fun (x, body) ->
    check_scope (x :: env ) body
