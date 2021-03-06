(* ML interpreter / type reconstruction *)
type id = string

type binOp = Plus | Mult | Lt

type exp =
    Var of id
  | ILit of int
  | BLit of bool
  | BinOp of binOp * exp * exp
  | IfExp of exp * exp * exp
  | LetExp of id * exp * exp
  | FunExp of id * exp
  | AppExp of exp * exp
  (* | LetRecExp of id * id * exp * exp *)

type program =
    Exp of exp
  | Decl of id * exp

type ty =
    TyInt
  | TyBool

let pp_ty = function
    TyInt -> print_string "int"
  | TyBool -> print_string "bool"
