-module(fib).
-export([main/1, fib/2]).

%% fib(N, N1) ->
%%    
%%
%%
%%

main(N) ->
    main(N, 0, spawn(fib, fib, [1, 0])).

main(N, N, Fib) ->
    Fib ! fin,
    io:format("end~n");
main(N, Cnt, Fib) ->
    Fib ! {self(), next},
    receive
	X -> io:format("fib(~p):~p~n", [Cnt+1, X]),
	     main(N, Cnt+1, Fib)
    end.

    
