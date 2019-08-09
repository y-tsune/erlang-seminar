-module(pmap).
-export([pmap/2, fact/1, run/1]).

fact(0) ->
    1;
fact(X) ->
    X * fact(X-1).

pmap(F, Ls) ->
    S = self(),
    L = lists:map(fun(X) -> spawn(fun() -> S ! {self(), F(X)} end) end, Ls),
    lists:map(fun(Pid) -> 
		      receive 
			  {Pid, Res} -> Res
		      end
	      end, L).
    
run(N) ->
    X = floor(math:pow(10, N)),
    L = lists:map(fun(_) -> floor(rand:uniform() * X) end, lists:seq(1, X)),
    pmap(fact, L).
    %% timer:tc(pmap, pmap, [fact, L]).
    %% io:format("~w~n", [timer:tc(pmap, pmap, [fact, L])]).
