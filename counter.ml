(* Making use of refs to create a counter. *)
let counter = ref 0

let next () =
  (* First time using the "sequence" operator, the semicolon. The semicolon throws away the value
     that the expression evaluates to. This is useful given that a `:=` expression evaluates to
     unit. *)
  counter := !counter + 1;
  !counter

(* There is a nicer way to encapsulate the counter into the function: *)
let next_nicer =
  let count = ref 0 in
  fun () ->
    count := !count + 1;
    !count
