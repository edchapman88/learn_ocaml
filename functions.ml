(* This is a "definition" rather than an "expression" *)
(* It is binding a "value" to an identifier. *)
let identifier = 5.

(* Bind a function (which is "value" in OCaml) to an identifier.
   let adder_long = fun x y -> x + y
*)

(* Shorthand for the above which the auto-formatter prefers! *)
let adder x y = x + y

(* Bind an "expression" to an identifier. *)
(* "values" can be thought of as a subset of "expressions",
   and "expressions" and "definitions" are distinct! *)
let res = adder 3 2

(* Partial function application, natural because all functions are actually single argument! *)
let add_three = adder 3

(* Polymorphic functions, a.k.a parametric polymorphism. *)
let poly x = x

(* An "if" expression bound to an identifier. *)
let branching = if 3 = 3 then 2. else 3.
let negation = if not (3 = 3) then "something" else "other"

(* Using the recursion keyword. *)
let rec factorial n = if n = 0 then 1 else n * factorial (n - 1)

(* Idomatic function names in OCaml describe the transformation they carry out. *)
let x = string_of_int 3

(* The pipe operator can be very useful for calling lots of functions after one another. *)
let double x = 2 * x
let add_three x = x + 3

(* The brackets are required by the compiler, and make it hard to read. *)
let eight_times x = double (add_three (double x))

(* Improvement is this: *)
(* Note that the pipe operator pipes the value into the final position in a argument list. *)
let eight_times_better x = x |> double |> add_three |> double

(* Polymorphic function stacking? *)
let twice f x = x |> f |> f
let forth_pow = twice (fun x -> x * x)

(* Map and Fold *)
let rec mymap f = function
  | [] -> []
  | h :: t -> f h :: mymap f t

let rec fold acc f = function
  | [] -> acc
  | h :: t -> fold (f acc h) f t
