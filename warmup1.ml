(* Problem 1.1. Scoping Puzzles *)

(* (a) *)
    let x = 1 in
    let f = fun () -> x in
    let x = 2 in
    f ()

(*    
Solution part A:

Result: 1

Explanation:

The expression evaluates to 1 because OCaml uses static / lexical scoping. When f is defined, its referencing environment contains the original binding x = 1. The function creates a closure, which preserves access to that binding. The let x = 2 is another binding but it only shadows the original x and does not modify it. Since its lexical scope, the reference of x inside f function is determined by the function's definition location and not it's calling location. The binding is resolved lexically and the close captures the associated environment when the function is created at runtime. So, calling f () returns 1 and not 2. 
*)

(* (b) *)
    let x = 10 in
    let g =
        let x = 20 in
        fun () -> x
    in
    let x = 30 in
    g ()

(* 
Solution part B:

Result: 20

Explanation:

Since OCml uses lexical scoping, the variable references are determined by where a function is defined from instead of being called. When g is created, the inner lex x = 20 shadows the outer x = 10 binding. The function forms a closure that captures the referencing environment containing x = 20. Lexical scope determines which x is referenced and the closure captures this binding at runtime when the function is created. The x = 30 creates a new binding that shadows but doesn't change the closure's environment. Therefore, g () prints 20. 
*)

(* (c) *)
    let make_discount rate = fun price -> price *. (1.0 -. rate)
    let discount = make_discount 0.1
    let rate = 0.05
    let final_price = discount 100.0

(* 
Solution part C:

Result: Static scope = 90.0 / Dynamic Scope = 95.0

Explanation:

Under static scoping the function returned by make_discount captures rate = 0.1 binding in its referencing environment when the closure is made. The rate = 0.05 is a separate binding that does not change the closure. Since 0.1 is passed for the rate parameter, discount 100.0 evaluates to: 100.0 *. (1.0 -. 0.1) = 90.0. If we were to use dynamic scoping, the free variable rate would be resolved using the active calling environment. When discount 100.0 is called, the top level rate binding x = 0.05 is used for the function instead of 0.1. The result would then become 100.0 *. (1.0 -. 0.05) = 95.0. The difference between static scope and dynamic scoping is that dynamic scope uses the runtime call chain while static resolves variable references through lexical environments. 
*)

(* (d)  *)
    let x = 5
    let f x = x * 2
    let g y = f y + x

(*
Solution part D:

Result: g 3 = 11

Explanation:

There are 2 binding occurrences of x. 1. let x = 5 introduces the top level binding x = 5. 2. let f x introduces a parameter binding for x which is local to the function f. There are also 2 bound occurrences of x. 1. the x in x * 2 refers to the parameter x declared in f. This param shadows the top level x within the body of f. 2. the x in f y + x refers to the top level binding x = 5 because f's parameter x is only visible inside f. This happens because OCaml uses lexical scoping so each variable reference is resolved based on its lexical environment. The top level binding is created during evaluation and a new parameter binding for f is created on each call. When g 3 is evaluated, y is 3. The call f 3 returns 3 * 2 = 6. The top level x adds 5. Therefore, g 3 = 6 + 5 = 11.
*)


