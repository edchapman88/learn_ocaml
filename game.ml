module type M = sig
  type 'a obs
  type 'a state

  type 'a action =
    | Intervene of 'a
    | Abstain

  type reward =
    | Win
    | Lose

  val observe : 'a state -> 'a obs
  val act : 'a state -> 'a action -> reward option
  val gameover : 'a state -> bool
end
