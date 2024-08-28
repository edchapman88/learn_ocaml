(* Varients are 'tagged unions'. See [1] description below. *)

type color =
  | Red
  | Green
  | Blue

type point = float * float

(* Varients with data 'carried' by the 'constructors'. *)
type shape =
  | Circle of {
      center : point;
      radius : float;
    }
  | Rectangle of {
      upper_right : point;
      lower_left : point;
    }

(* This is a 'non-constant' varient expression bound to an identifier. *)
let circ = Circle { center = (1., 2.); radius = 2. }

(* In contrast with a 'constant' varient expression bound to an identifier. *)
let r = Red

(* [1] Tagged Unions: *)
(* This type is a union between the `string` type and the `int` type. *)
type string_or_int =
  | String of string
  | Int of int

(* But the varient constructors also act as tags such that if constructors have the same type,
   we can still know which set the item came from. A.K.A tagged union. *)
type coloured_ints =
  | Blue of int
  | Pink of int

(* Match on tags. *)
let centre = function
  | Circle { center; _ } -> center
  (* Deep matching. *)
  | Rectangle { upper_right = r_x, u_y; lower_left = l_x, l_y } ->
      let avg a b = (a +. b) /. 2. in
      (avg r_x l_x, avg u_y l_y)

(* Varients with other data types. *)
type vehicle =
  | Car of (int * int)
  | Boat of int list * int

let v_prop = function
  | Car whole -> whole
  | Boat (lst, snd) -> (
      match lst with
      | [] -> (snd, snd)
      | h :: _ -> (h, snd))

(* Weird find:
   The brackets around the tuple make a difference when trying to match on the whole! *)
type weird =
  | Car of int * int
  | Boat

(* This doesn't work!! *)
(* let w = function Car whole -> whole | Boat -> (1, 2) *)
(* But this does! *)
let w = function
  | Car (fst, snd) -> (fst, snd)
  | Boat -> (1, 2)

(* Constructors get shadowed. But type annotation seems to fix it no? *)
type my =
  | Norm
  | Un

type shadow =
  | Norm
  | Op

let x = Norm
let y : my = Norm

(* Recursive Varients! *)
type intlist =
  | Nil
  | Cons of int * intlist

let one_two = Cons (1, Cons (2, Nil))

(* Parameterised recursive varients. Technically `somelist` is a 'type constructor because it
   constructs a type (e.g. `int somelist`) by taking in the type 'a. *)
type 'a somelist =
  | Nil
  | Cons of 'a * 'a somelist

let rec length = function
  | Nil -> 0
  | Cons (_, t) -> 1 + length t

(* Can even bring in operators. *)
type 'a thelist =
  | []
  | ( :: ) of 'a * 'a thelist

let rec len = function
  | [] -> 0
  | _ :: t -> 1 + len t

(* Results and Options follow. *)
type 'a myoption =
  | None
  | Some of 'a

(* type 'a 'b myresult = Ok of 'a | Err of 'b *)

(* Can you have varients with the data being functions? *)
type funcy =
  | Add of (int -> int -> int)
  | Ln of (float -> float)

(* There is lots to this line:
   - Making a list containing several differnt types using constructors of the same Varient opens
     the door to inhomogenous lists!
   - We've shown you can have varient constructors of functions.
   - And the standard library `list` type constructor has been shadowed by our own implementation! *)
let funky = [ Add ( + ); Ln (fun x -> log x) ]

(* Options can be handled as part of pipelines with `Option.map` and `Option.bind`. *)
(* Open the std lib `Option` module directly to shadow `myoption` above. *)
open Option

(* We would like to be able to work with all of the following 3 signatures: *)
(* Take a value, return an Option. *)
let wrap x = Some x

(* Take a value, return a value. *)
let add1 x = x + 1

(* Take a value, return an Option. *)
let over_and_out x = if x > 5 then None else Some x

(* Note that the pipe operator pipes the value into the final position in a argument list.
   So `Option.map add1 (wrap 2)` is called as we would like. *)
let y = 2 |> wrap |> Option.map add1 |> is_some

(* We can make a custom in-fix operator out of `Option.map` *)
(* Note this is the conventional operator for `Option.map`. *)
let ( >>| ) t f = Option.map f t

(* For some reason the argument ordering is different for `.bind`. *)
let ( >>= ) = Option.bind
let y_prime = 2 |> wrap >>| add1 >>= over_and_out
