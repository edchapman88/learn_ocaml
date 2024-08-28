(* Refs are pointers to typed locations in memory. *)
(* Bindings between identifiers and refs are immutable. But the contents of a ref are mutable. *)
let x = ref 3

(* Dereference with bang operator. *)
let y = !x

(* A new value can be assigned to the contents of the ref with `:=`. Unit is returned by the
   assignment. *)
let _ = x := 2
