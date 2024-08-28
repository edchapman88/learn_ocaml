(* Operators are functions, they can be used "prefix" as well as "infix". *)
let four = 1 + 3
(* The functional version gets auto-formatted!
   let also_four = ( + ) 1  3
*)

(* Some operators are polymorphic, others aren't. *)
let not_poly_add_f = ( +. )
let poly_equality = ( = )
let poly_gt = ( > )

(* You can make your own operators from any function. *)
(* There are rules about which punctuation you can use in your custom "infix" operators. *)
let ( <^> ) a b = max a b
let bigger = 3 <^> 4
