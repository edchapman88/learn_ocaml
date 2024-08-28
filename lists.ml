(* Lists are singly-linked, constructed as follows:
   let seq = 1 :: 2 :: 3 :: []
*)

(* [] is "nil", :: is "cons" *)

(* Shorthand is prefered. *)
let seq = [ 1; 2; 3 ]

(*  Make a new list from a list. Lists are immutable, this is not pushing! *)
let new_list = 1 :: [ 2; 3 ]

(* Match on the head and tail. *)
let head_or_zero =
  match seq with
  | [] -> 0
  | h :: _ -> h

(* Nested lists are valid. *)
let nested = [ 1; 2 ] :: []
let nested_shorthand = [ [ 1; 2 ]; [ 3; 4 ] ]

(* Is my list empty? *)
let empty lst =
  match lst with
  | [] -> true
  | _ -> false

(* Sum or a list?  *)
(* Find out how your recursion is working with a `#trace sum;;` command in utop. *)
let rec sum lst =
  match lst with
  | [] -> 0
  | h :: t -> h + sum t

(* Implementation with tail recursion. *)
let rec sum_tail_rec lst =
  let rec aux acc tail =
    match tail with
    | [] -> acc
    | h :: t -> aux (acc + h) t
  in
  aux 0 lst

(* Appending lists with an in-fix in the standard library. *)
let longer = [ 1; 2; 3 ] @ [ 4; 5; 6 ]

(* Note its polymorphic as expected. *)
let append_func = ( @ )
