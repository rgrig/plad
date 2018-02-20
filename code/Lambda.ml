type var = string [@@deriving show, ord]

type term =
  | Var of var
  | Abs of var * term
  | App of term * term
  [@@deriving show]

module Context : sig
  type t
  val empty : t
  val lookup : t -> var -> term
  val add : t -> var -> term -> t
  val del : t -> var -> t
end = struct
  module M = Map.Make (struct type t = var [@@deriving ord] end)
  type t = term M.t
  let empty = M.empty
  let lookup context x = try M.find x context with Not_found -> Var x
  let add context x t = M.add x t context
  let del context x = M.remove x context
end

let rec substitute context = function
  | Var x -> Context.lookup context x
  | Abs (x, t) -> Abs (x, substitute (Context.del context x) t)
  | App (t1, t2) -> App (substitute context t1, substitute context t2)

(* Using OCaml reduction strategy: strict, and not descend below Abs. *)
let rec eval context = function
  | App (Abs (x, t1), t2) -> eval (Context.add context x (eval context t2)) t1
  | t -> substitute context t

let () =
  let t = (App (Abs ("x", App (Var "x", Var "x")), Var "y")) in
  Format.printf "before: %a@\nafter: %a@\n" pp_term t pp_term (eval Context.empty t)
