(* Signatures provide a way to define module interfaces. Documentation should primarily be in the
   module signature, rather than the module implementation. *)

module type Fact = sig
  (* [fact n] is [n] factorial. *)
  val fact : int -> int
end

(* An implementation: *)
module RecursiveFact : Fact = struct
  let rec fact = function
    | 0 -> 1
    | n -> n * fact (n - 1)
end

(* Imposing a module type onto a module also makes any values that are not in the interface
   private! "A module is sealed at the specification of the signature". *)
module TailRecursiveFact : Fact = struct
  let rec fact_aux n acc = if n = 0 then acc else fact_aux (n - 1) (n * acc)
  let fact n = fact_aux n 1
end

(* Can't access `fact_aux! *)
(* let x = TailRecursiveFact.fact_aux 10 1 *)

(* Module signatures should be flexible enough to capture differnet implementations.
   Revisiting the `Stack` and `OtherStack` implementations in `structures.ml`: *)
module type StackSig = sig
  (* ['a stack] is the representation type for stacks *)
  type 'a stack

  val empty : 'a stack
  val push : 'a -> 'a stack -> 'a stack
  val peek : 'a stack -> 'a
end

(* With the generality provided by the representation type, both stack implementations conform
   to the interface. *)
module MyStack : StackSig = struct
  type 'a stack =
    | Empty
    | Entry of 'a * 'a stack

  let empty = Empty
  let push x s = Entry (x, s)

  let peek = function
    | Empty -> failwith "Empty"
    | Entry (x, _) -> x
end

(* Note I haven't yet imposed the `StackSig` signature on the `OtherStack` type (to show that it
   can be done afterwards too). *)
module OtherStack = struct
  type 'a stack = 'a list

  let empty = []
  let push x s = x :: s

  let peek = function
    | [] -> failwith "Empty"
    | x :: _ -> x
end

(* Can also do a post-hoc 'typing' of a module: *)
(* Here the new module diefinition shadows the one above. *)
(* This is an example of binding a 'module value' in a module definition, rather than a
   'structure'. *)
module OtherStack : StackSig = OtherStack

(* Implementations are allowed to be more general than the signature. *)
module NotReallyFactButAllowed : Fact = struct
  (* The identity function, `'a -> 'a`, which is a more general type than the one specified
     in the signature: `int -> int`. *)
  let fact x = x
end

(* Signatures provide a way to define abstract types. The underlying implementation of the
   abstract type in a structure is sealed inside the module. *)
module type MyQueue = sig
  (* It's conventional to define a main abstract type of a signature `t`. *)
  type 'a t

  val empty : 'a t
end
