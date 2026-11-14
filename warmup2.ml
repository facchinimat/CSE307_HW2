(* Problem 1.2. Recursive and Polymorphic Operations *)


(* Problem 1.2(a) - Remove duplicates *)
let rec contains item lst =
    match lst with
    | [] -> false
    | head :: tail ->
        head = item || contains item tail

let remove_duplicates lst =
    let rec aux seen remaining = 
        match remaining with
        | [] -> []
        | head :: tail ->
            if contains head seen then
                aux seen tail
            else
                head :: aux (head :: seen) tail
    in
    aux [] lst

(* Problem 1.2(b) - Association Lists *)

let rec lookup key env =
    match env with
    | [] -> None
    | (k, v) :: rest ->
        if k = key then
            Some v
        else
            lookup key rest
let extend key value env =
    (key, value) :: env

(* Problem 1.2(c) - Arithmetic Expression Evaluator *)
type arith_expr =
    | Const of int
    | Add of arith_expr * arith_expr
    | Mul of arith_expr * arith_expr

let rec eval expr =
    match expr with
    | Const n -> n
    | Add (a,b) -> eval a + eval b
    | Mul (a,b) -> eval a * eval b