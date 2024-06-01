open Printf
open Effect
open Effect.Deep

module type MONAD = sig
  type 'a t
  type ('i,'o) efft
  val return : 'a -> 'a t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val fire : ('i,'o) efft -> 'i -> 'o t
end

module Effect (M : MONAD) = struct

  type _ Effect.t += Eff : ('i,'o) M.efft * 'i -> 'o Effect.t
  let eff : ('i,'o) M.efft -> 'i -> 'o = fun e i -> perform (Eff(e,i))

  let run (type a) (f : 'b -> a) : 'b -> a M.t =
    let comp y =
      match_with f y
      { retc = M.return;
        exnc = (fun e -> raise e);
        effc = fun (type b) (e : b Effect.t) ->
                 match e with
                 | Eff(e,x) -> Some (fun (k : (b, a M.t) continuation) ->
                     M.bind (M.fire e x) (continue k))
                 | e -> None
       }
    in comp
end

module State (S: sig type s end)(*:
 MONAD
  with type 'a t = S.s -> S.s * 'a
  type ('i,'o) efft =
   | Set : (S.s,unit) efft
   | Get : (unit,S.s) efft
   | Swap : (S.s,S.s) efft
*)
= struct
  type 'a t = S.s -> S.s * 'a
  type ('i,'o) efft =
   | Set : (S.s,unit) efft
   | Get : (unit,S.s) efft
   | Swap : (S.s,S.s) efft
  let return x s = s,x
  let bind g f s = let s',x = g s in f x s'
  let fire (type i) (type o) : (i,o) efft -> i -> o t =
   function
    | Get -> fun () s -> s,s
    | Set -> fun n _ -> n,()
    | Swap -> fun n s -> n,s
end

module IM = State(struct type s = int end)
module IS = Effect(IM)
module SM = State(struct type s = string end)
module SS = Effect(SM)
let iswap = IS.eff IM.Swap
let sswap = SS.eff SM.Swap

let foo x : unit =
  IS.eff IM.Set x;
  printf "%d\n" (iswap 2);
  printf "%s\n" (sswap "stai");
  printf "%d\n" (IS.eff IM.Get ());
  printf "%s\n" (SS.eff SM.Get ())

let _ = IS.run (fun x -> SS.run foo x "come") 7 1
