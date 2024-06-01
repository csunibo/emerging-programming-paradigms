-module(tr).
-export([sum/1,sum/2,somma/2,cpssum/1]).

% Problema: sommare tutti i numeri di una lista di numeri

% Soluzione non tail ricorsiva
% occupa O(len(L)) RAM
sum([]) -> 0 ;
sum([H|T]) -> H + sum(T).

% Soluzione tail ricorsiva
% occupa O(1) RAM
sum([],A) -> A ;
sum([H|T],A) -> sum(T,H+A).


% Trasformazioni meccaniche:

% 1: implemento "a mano" uno stack delle chiamate
% ==> non uso più lo stack di sistema ma gestisco io uno stack nello heap
% ==> utile solamente quando il linguaggio gestisce heap di dimensione piccola
% ==> e fissata

somma([],S) -> pop(0,S) ;
somma([H|T],S) -> somma(T,push(S,fun (R) -> H + R end)).

push(S,F) -> [F|S].
pop(R,[]) -> R ;
pop(R,[F|S]) -> pop(F(R),S).

%    somma([1,2,3], [])
% -> somma([2,3], [fun (R) -> 1 + R end])
% -> somma([3], [fun (R) -> 2 + R end,
%                fun (R) -> 1 + R end])
% -> somma([], [fun (R) -> 3 + R end,
%               fun (R) -> 2 + R end,              
%               fun (R) -> 1 + R end])
% -> pop(0, [fun (R) -> 3 + R end,
%            fun (R) -> 2 + R end, 
%            fun (R) -> 1 + R end])
% -> pop(3, [fun (R) -> 2 + R end, 
%            fun (R) -> 1 + R end])
% -> pop(5, [fun (R) -> 1 + R end])
% -> pop(6, [])
% -> 6

% Riscritto con i while
% L = lista iniziale da sommare
% S = []
% continue = true
% while(continue) {
%  case L of
%    [] -> pop(0); continue <- false
%    [H|T] -> push(fun (R) -> H + R end); L <- T
%  }
%
% push(F) { S <- [F|S] }
% 
% pop(R) {
%  continue = true
%  while(continue)
%  case S of
%    [] -> return R
%    [F|T] -> R <- F(R); S <- T;
% }


% 2: applico la CPS translation (Continuation Passing Style)
% proprietà: dopo aver applicato la CPS, tutte le chiamate sono di coda
%
% Idea: ogni funzione prende in input la funzione che esegue il lavoro
% che deve essere eseguito dopo che la funzione è ritornata

cpssum([],K) -> K(0) ;
cpssum([H|T],K) -> cpssum(T,fun (R) -> K(H + R) end).

cpssum(L) -> cpssum(L, fun (R) -> R end).

% cpssum([1,2,3])
% -> cpssump([1,2,3], fun (R) -> R end)
% -> cpssum([2,3], fun (R) -> (fun (R) -> R end)(1 + R) end)
% -> cpssum([3], fun (R) -> (fun (R) -> (fun (R) -> R end)(1 + R) end)(2 + R) end)
% -> cpssum([], fun (R) -> (fun (R) -> (fun (R) -> (fun (R) -> R end)(1 + R) end)(2 + R) end)(3 + R) end)
% -> (fun (R) -> (fun (R) -> (fun (R) -> (fun (R) -> R end)(1 + R) end)(2 + R) end)(3 + R) end)(0)
% -> (fun (R) -> (fun (R) -> (fun (R) -> R end)(1 + R) end)(2 + R) end)(3)
% -> (fun (R) -> (fun (R) -> R end)(1 + R) end)(5)
% -> (fun (R) -> R end)(6)
% -> 6
