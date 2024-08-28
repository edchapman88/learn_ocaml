(* Record types. *)
type student = {
  name : string;
  id : int;
  school : string;
}

let ed = { name = "ed"; id = 1; school = "Primary" }

(* Record "copy" is not mutation! It's a shorthand for making new records from existing ones. *)
let other_ed = { ed with id = 12; school = "Secondary" }

(* Records and tuples are 'product types' (compared to 'union' or 'sum' types of Varients). *)
