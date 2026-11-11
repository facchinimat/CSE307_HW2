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