(* Esempio: un effetto algebrico che prende un booleano
   e restituisce un intero *)

(* Step 1: aggiungo al tipo di dato algebrico generalizzato
   APERTO un nuovo costruttore per il mio effetto *)

type _ Effect.t += EInt  : int -> bool Effect.t
type _ Effect.t += EBool : bool -> int Effect.t

(* Al momento della chiamata della prima perform (su EBool true) la fibra contiene il RA di f e il registro PC punta
a l'istruzione Effect.perform (EBool true).
*)

let f () : unit =
 Printf.printf "%d\n"
  (Effect.perform (EBool true) + 
    if Effect.perform (EInt 3) then 2 else
     Effect.perform (EBool false))

let _ =
 Effect.Deep.try_with f ()
  {Effect.Deep.effc =
    fun (type c) (x: c Effect.t) :
    ((c,_) Effect.Deep.continuation -> _)option->
     match x with
      | EInt n ->
         Some (fun (k : (bool,_) Effect.Deep.continuation) -> Effect.Deep.continue k false)
      | EBool b -> Some (fun (k : (int,_) Effect.Deep.continuation) -> Effect.Deep.continue k (if b then 2 else 4))
      | _ -> None
  }
