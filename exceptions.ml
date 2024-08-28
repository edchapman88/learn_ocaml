(* The type `exn` is the built-in exception Varient. *)
(* It is a special 'extensible varient'! It is extended by using the keyword `exception`. *)
exception TestFailed

let my_exception = TestFailed

(* `exn` can be extended with non-constant constructors too. *)
exception
  OhNo of {
    message : string;
    id : int;
  }

(* Raise exceptions with `raise`. *)
let break_it = function
  | true -> raise (OhNo { message = "game over"; id = 1 })
  | false -> ()

(* There are some useful `exn` constructors pre-defined in the standard library. *)
let a = Failure "For when a function is undefined on the given args"
let b = Invalid_argument "For when args don't make sense"

(* There are even convenience fucntions to raise these two `exn` constructors: *)
let longhand_raise = raise (Failure "And the string")
let make_it_fail_fast = failwith "This string"
let the_other = invalid_arg "And here"

(* Handling exceptions gracefully. *)
let safe_div x y = try x / y with Division_by_zero -> 0
