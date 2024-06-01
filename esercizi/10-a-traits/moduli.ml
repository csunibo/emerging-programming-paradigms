(* Non-first class modules *)

module M =
struct
  type t = int * int

  type tagged_t = T1 of t | T2 of t

  let f =
   function
      T1 x -> x
    | T2 x -> x

  module N :
  sig
   type s1
   type s = s1 list

   val mk_s : bool -> t -> s
   val f : s -> t list
   val id : ('a*'b) -> 'a*'b
  end
  =
  struct
    type s1 = tagged_t
    type s = tagged_t list

    let mk_s b t =
     if b then [T1 t] else [T2 t]

    let f = List.map f

    let id y = y
  end
end

let x = M.T1(2,3)
let y = M.N.f (M.N.mk_s true (2,3))

module type Dictionary =
sig
   type k
   type 'a t

   exception Absent

   (* it may raise Absent *)
   val search : k -> 'a t -> 'a
end


(* Funtore = funzione di seconda classe da moduli a moduli *)
module BST(
 Key : sig
        type k
        val eq : k -> k -> bool
        val leq : k -> k -> bool
       end)
 : Dictionary with type k = Key.k
=
struct
   type 'a tree = Empty | Node of Key.k * 'a * 'a tree * 'a tree

   type k = Key.k
   type 'a t = 'a tree

   exception Absent

   let search k =
    let rec aux =
     function
        Empty -> raise Absent
      | Node(k',v,l,r) ->
         if Key.eq k k' then v
         else if Key.leq k k' then
          aux l
         else aux r
    in
     aux
end

module IntIntKey =
struct
 type k = int*int
 let eq (x1,y1) (x2,y2) = x1=x2 && y1=y2
 let leq (x1,y1) (x2,y2) = x1 < x2 || (x1 = x2 && y1 <= y2)
end

module BSTIntInt = BST(IntIntKey)

let foo = BSTIntInt.search (2,3);;
