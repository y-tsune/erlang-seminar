-module(select).
-export([main/1, loop/2, p/2]).

p(N, M) ->
    receive
	N ->
	    M ! N
    end.

loop(_, 0) ->
    stop;

loop(P, N) ->
    P ! N,
    loop(P, N-1).

main(N) ->
    loop(spawn(select, p, [N div 2, self()]), N),
    receive
	X ->
	    io:format("~p~n", [X])
    end.
	     
    
	
