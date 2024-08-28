(* Modules and Structures are a way to group and namespace related code to prevent undesirbale
   shadowing in the 'global' namespace. *)

module MyStack = struct
  type 'a stack =
    | Empty
    | Entry of 'a * 'a stack

  let empty = Empty
  let push x s = Entry (x, s)

  let peek = function
    | Empty -> failwith "Empty"
    | Entry (x, _) -> x
end

(* Side-note: the functionality here is actually the same as a `List`. *)
module OtherStack = struct
  type 'a stack = 'a list

  let empty = []
  let push x s = x :: s

  let peek = function
    | [] -> failwith "Empty"
    | x :: _ -> x
end

(* Using code within a module. *)
let a = MyStack.empty |> MyStack.push 3 |> MyStack.peek

(* An improvement would be: *)
let a = MyStack.(empty |> push 3 |> peek)

(* Or open a module 'locally' for a longer context. *)
let x =
  let open MyStack in
  let b = empty |> push 1 |> peek in
  let c = empty |> push 2 |> push 4 |> peek in
  b + c

(* Open a module 'globally' for the while file of code.
   WARNING: Modules will shadow one another when opened, so should be used sparingly when it is known
   that shadowing will not occur. *)
open MyStack

let y = empty |> push 3 |> peek
