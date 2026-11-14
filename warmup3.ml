(* Problem 1.3. Closures and Higher Order Functions in OCaml *)

(* Problem 1.3(a) *)

let make_counter () =
  let count = ref 0 in
  fun () ->
    count := !count + 1;
    !count

(* Problem 1.3(b) *)
let compose f g x =
  f (g x)

let transform =
  compose (fun x -> x -1) (fun x -> x * 2)

let () =
  Printf.printf "transform 1 = %d\n" (transform 1);
  Printf.printf "transform 3 = %d\n" (transform 3);
  Printf.printf "transform 5 = %d\n" (transform 5)


(* Problem 1.3(c) *)
let curry f x y =
  f (x, y)

let uncurry f (x, y) =
  f x y

let add x y = x + y

let () =
  assert (curry (uncurry add) 3 4 = add 3 4)

(* Problem 1.3(d) *)

(* Most general type is ('a -> 'a) -> 'a -> 'a
Since f is applied twice its output type must match its input type. Therefore, f must have type a -> a and apply twice returns a.
*)

let apply_twice f x =
  f (f x)