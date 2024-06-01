-module(search).
-export([main/0]).

% Alberti:  T := nil | {node, T, K, V, T}

% In caso di successo, per restituire il valore può arrivare a fare
% O(n) case secondo ramo
search(_,nil) -> not_found ;
search(K,{node, _, K, V, _}) -> V ;
search(K,{node, L, _, _, R}) ->
 case search(K,L) of
    not_found -> search(K,R) ;
    V -> V
 end.

% Implementazione con eccezione
s(_,nil) -> not_found ;
s(K,{node, _, K, V, _}) -> throw({found, V}) ;
s(K,{node, L, _, _, R}) ->
 s(K,L),
 s(K,R).

search2(K,T) ->
 try s(K,T)
 catch {found, R} -> R
end.

main() ->
 search(3, {node, nil, 3, trovato, nil}),
 search2(3, {node, nil, 3, trovato, nil}).
