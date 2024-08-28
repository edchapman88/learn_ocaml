(* Unlike records, tuples are strictly ordered. *)
let t = (1, "mixed types!", true)

(* Standard library has helper functions to get elements from 2-element tuples (pairs) only.
   If you want to match on larger tuples, you do it yourself. *)
let pair = (1, "second")
let first = fst pair
let second = snd pair

(* Match on a tuple. *)
let middle =
  match t with
  | f, s, t -> s

(* And the polymorphic function that gets the middle element in a triple. *)
let middle some_tuple =
  match some_tuple with
  | f, s, t -> s
