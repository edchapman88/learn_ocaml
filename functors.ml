(* Functors are functions operating on modules. *)
module type X = sig
  val x : int
end

module A = struct
  let x = 3
end

(* `IncX` is a functor that operaters on any modules that conform to the signature `X`. *)
(* Note that the module type of the input module **must** always be specified. E.g. `X` in this
   case. *)
module IncX =
functor
  (M : X)
  ->
  struct
    let x = M.x + 1
  end

(* Use the functor. *)
module IncA = IncX (A)

(* There is also a shorthand for defining functors (similar to the shorthand for defining
   functions.) *)
module IncXShortHand (M : X) = struct
  let x = M.x + 1
end

(* The functor doesn't have to return a module the conforms to the same signature as the signature
   of the input.*)
module XAndZero (M : X) = struct
  let x = M.x
  let zero = 0
end

module type Y = sig
  val y : string
end

(* An off-piste guess at how functor types work! *)
module type Test = functor (_ : X) -> Y
