(* There is a shorthand for immediatly pattern matching on the input to a function. *)
(* It uses the keyword `function`; which is not to be confused with `fun`, which is
   used in the syntax for anonomous function expressions. *)

(* Longhand. *)
let empty_long lst =
  match lst with
  | [] -> true
  | _ -> false

(* Shorthand. *)
let empty = function
  | [] -> true
  | _ -> false

(* The syntax generalises to multiple function arguments, in the 'lambda' style you would
   expect. E.g. the last argument is the one immediately matched on. *)

let is_c_empty a b = function
  | [] -> true
  | _ -> false

(* False. *)
let is_it = is_c_empty [ 'a' ] [ 'b' ] [ 'c' ]

(* Can match on multiple identifiers of the same type in one go. *)
type colour =
  | Red
  | Blue

let same c1 c2 =
  match (c1, c2) with
  | Red, Blue | Blue, Red -> false
  | Red, Red | Blue, Blue -> true

(* Note: an alternative, not better or worse, is this: *)
let same = function
  | Red, Blue | Blue, Red -> false
  | Red, Red | Blue, Blue -> true
(* The differnece being the way they are called, either with two args, or a single tuple. *)
