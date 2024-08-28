(* This is an interface file, which contains the "declarations" for a module signature. *)
(* The type of the stack, whose elements are of type 'a. *)
type 'a t

(* The empty stack. *)
val empty : 'a t

(* [push x s] is the stack [s] with [x] pushed on the top. *)
val push : 'a -> 'a t -> 'a t
