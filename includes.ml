(* Includes are a way to share parts of modules of module types. *)
(* `include` exposes the included functionality (hover of `Field` on ln 41 to see that in action).
   `Note this is different to using `open` in a definition! `open` makes functionality available from
   another scope, but does not "re-expose" that functionality. See below a comparison between `open`
   and `include`. *)

module type Ring = sig
  type t

  val zero : t
  val one : t
  val ( + ) : t -> t -> t
end

module type Field = sig
  include Ring

  val ( / ) : t -> t -> t
end

(* Impl `Ring` for `int`. *)
(* Notice that `IntRing` does conform to `Ring`, however we do *not* "seal" `IntRing` at that
   interface! Otherwise we wouldn't be able to `include` `IntRing` in the definitions for
   `IntField`. This is because "sealing" would cause the types in `IntRing` to become abstract
   (`t`), and for an include in IntField we need the types to be `int`.*)
module IntRing = struct
  type t = int

  let zero = 0
  let one = 1
  let ( + ) = ( + )
end

(* Impl `Ring` for `float`. *)
(* Here we "seal" the `FloatRing` module to the `Ring` signature, and it makes the types abstract. *)
module FloatRing : Ring = struct
  type t = float

  let zero = 0.
  let one = 1.
  let ( + ) = ( +. )
end

(* Impl `Field` for `int`, making use of the earlier impl of `IntRing`. *)
module IntField : Field = struct
  include IntRing

  let ( / ) = ( / )
end

(* If we still wanted to have a "sealed" version of `IntRing`, we can: *)
module IntRingSealed : Ring = IntRing

(* Comparing `open` to `include`. *)
module M = struct
  let x = 0
end

module N = struct
  include M

  let y = x + 1
end

module O = struct
  open M

  let y = x + 1
end

let a = N.y
let b = O.y
let c = N.x
(* let broken = O.x *)
