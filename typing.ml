open Syntax

exception Error of string

let err s = raise (Error s)

(* type environment *)
type tyenv = ty Environment.t

let ty_prim op ty1 ty2 = match op with
    Plus -> (
                match ty1, ty2 with
                TyInt , TyInt -> TyInt
                | _ -> err ("Argument must be of integer: + \n")
               )
  | Mult ->(
    match ty1, ty2 with
      TyInt, TyInt -> TyInt
    | _ -> err ("Argument must be of integer: * \n")
      )

let rec ty_exp tyenv = function
    Var x ->
    (try Environment.lookup x tyenv with
       Environment.Not_bound -> err ("variable not bound:  " ^ x))
  | ILit  _ -> TyInt
  | BLit  _ ->  TyBool
  | BinOp (op, exp1, exp2) ->
     let tyarg1 = ty_exp tyenv exp1 in
     let tyarg2 = ty_exp tyenv exp2 in
     ty_prim op tyarg1 tyarg2
  | _ -> err ("Not Implemented! \n")

let ty_decl tyenv = function
    Exp e -> ty_exp tyenv e
  | _ -> err ("Not Implemented !\n")
