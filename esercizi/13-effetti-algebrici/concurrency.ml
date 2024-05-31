open Printf
open Effect
open Effect.Deep

type _ Effect.t += Fork : (unit -> unit) -> unit t
                 | Yield : unit t

type _ Effect.t += Xchg : int -> int t

let fork f = perform (Fork f)
let yield () = perform Yield
let xchg v = perform (Xchg v)

(* A concurrent round-robin scheduler *)
let run (main : unit -> unit) : unit =
  let exchanger = ref None in (* waiting exchanger *)
  let run_q = Queue.create () in (* scheduler queue *)
  let enqueue k v =
    let task () = continue k v in
    Queue.push task run_q in
  let dequeue () =
    if Queue.is_empty run_q then () (* done *)
    else begin
      let task = Queue.pop run_q in
      task ()
    end in
  let rec spawn (f : unit -> unit) : unit =
   match_with f () {
      retc = (fun () -> dequeue ());
      exnc = (fun e ->
        print_endline (Printexc.to_string e);
        dequeue ());
      effc = (fun (type a) (eff : a t) ->
        match eff with
        | Yield -> Some (fun (k : (a, unit) continuation)->
           enqueue k (); dequeue ())
        | Fork f -> Some (fun (k : (a, unit) continuation) ->
           enqueue k (); spawn f)
        | Xchg n -> Some (fun (k : (int, unit) continuation) ->
           (match !exchanger with
            | None -> exchanger := Some (n, k) ; dequeue ()
            | Some (n',k') ->
                exchanger := None;
                enqueue k' n; continue k n'))
        | _ -> None)
   }
  in
  spawn main

let _ = run (fun _ ->
  fork (fun _ ->
    printf "[t1] Is alive\n";
    yield ();
    printf "[t1] Sending 0\n";
    let v = xchg 0 in
    printf "[t1] received %d\n" v);
  fork (fun _ ->
    printf "[t2] Sending 1\n";
    let v = xchg 1 in
    printf "[t2] received %d\n" v))
