(* This is a module implementation, or "module definitions" for the `my_stack.mli` signature. *)
(* The two files with the same name, `my_stack.mli` and `my_stack.ml` form a "compilation unit",
   when found in the same directory. *)

(* Here a `list` is used as the "representation type" for the "data abstraction".
   The "abstraction function" describes how to interpret the representation type as the data
   abstraction. The description of the abstraction function is usually accompanied by the
   "representation invariant", which describes which values of the representation type are
   meaningful. Documentation for a given implementation of a signature should include descriptions
   of the abstraction function and the representation invariant. An example of representation
   invariant might be "The list must not contain duplicates", in the case of a list being used as the
   representation type for a set. *)

(* Abstraction functions should be commutative. This is a requirement for the implementation to be
   correct. E.g. abstract_operation(AF(concrete_thing)) == AF(concrete_operation(concrete_thing)) *)

(* AF: The list [[a1; ...; an]] represents the stack [(a1 -> ... -> an)].
   RI: None. *)
type 'a t = 'a list

let empty = []
let push x s = x :: s

(* This will be compiled to:

   module MyStack : [sig <declarations from .mli> end] = struct
     <definitions from this file>
   end
*)
