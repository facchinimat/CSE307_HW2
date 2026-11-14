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


(* Problem 3.2 - Type Constraint Generation *)

(* provided type definitions from assignment details *)
type typ =
  | TInt
  | TBool
  | TVar of string
  | TArrow of typ * typ

type 'a env = (string * 'a) list

let type_counter = ref 0

let fresh_type_var () =
  let name = "t" ^ string_of_int !type_counter in
  incr type_counter;
  TVar name

let rec gen_equations ( env : typ env ) ( e : expr )
  : typ * ( typ * typ ) list =
  match e with
  | Int _ ->
    (TInt, [])
  | Bool _ ->
    (TBool, [])
  | Var x ->
    (match List.assoc_opt x env with 
    | Some t -> (t, [])
    | None -> raise (UnboundVariable x))
  | Add (e1,e2) ->
    let (t1,c1 ) = gen_equations env e1 in
    let (t2, c2) = gen_equations env e2 in
    (TInt, c1 @ c2 @ [(t1, TInt); (t2, TInt)])
  | If (cond, e1, e2 ) ->
    let (tc, cc) = gen_equations env cond in
    let (t1, c1 ) = gen_equations env e1 in
    let (t2, c2) = gen_equations env e2 in
    (t1, cc @ c1 @ c2 @ [(tc, TBool); (t1,t2)])
  | Let (x, e1, e2) ->
    let (t1, c1) = gen_equations env e1 in
    let (t2,c2) = gen_equations ((x, t1) :: env ) e2 in
    (t2, c1 @ c2)
  | Fun (x, body ) ->
    let tx = fresh_type_var () in
    let (tb, cb ) = gen_equations ((x, tx) :: env) body in
    (TArrow (tx, tb), cb)
  | App (e1, e2 ) ->
    let ( tf, cf ) = gen_equations env e1 in
    let ( ta, ca ) = gen_equations env e2 in
    let tr = fresh_type_var () in
    (tr, cf @ ca @ [(tf, TArrow (ta, tr))])


(* Problem 3.3 - Unification Algorithm *)

let rec sub name replacement t =
  match t with
  | TInt -> TInt
  | TBool -> TBool
  | TVar x -> 
    if x = name then replacement else t
  | TArrow (t1, t2) ->
    TArrow ( sub name replacement t1, sub name replacement t2)


let rec occurs name t =
  match t with
  | TInt | TBool -> false
  | TVar x -> x = name
  | TArrow (t1, t2) ->
    occurs name t1 || occurs name t2

let unify (equations : (typ * typ) list )
    : (string * typ ) list =

    let rec solve equations subs = 
      match equations with
      | [] ->
        subs
      | (t1, t2 ) :: rest ->

        if t1 = t2 then
          solve rest subs
        else
          match (t1, t2) with
          | (TVar x, t) | (t, TVar x) ->
            if occurs x t then
              raise (TypeError ("Occurs check failed: " ^ x))
            else
              let new_r =
                List.map
                (fun (a,b) -> 
                  sub x t a, sub x t b)
                rest
              in
              let new_sub = 
                List.map
                (fun (name, typ) -> 
                  (name, sub x t typ ))
                subs
              in

              solve new_r
              ((x,t) :: new_sub)

        | (TArrow (a1, b1 ), TArrow (a2, b2)) ->
            solve ((a1, a2) :: (b1, b2) :: rest)
            subs
        | _ ->
          raise (TypeError "Incompatible types")
in
solve equations []
        