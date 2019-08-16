-module(pmap).
-export([pmap/2, fact/1, run/1]).

fact(0) ->
    1;
fact(X) ->
    X * fact(X-1).

pmap(F, L) ->
    S = self(),
    Ref = erlang:make_ref(),
    Pids = lists:map(fun(I) ->
			     spawn(fun() -> do_f(S, Ref, F, I) end)
		     end, L),
    gather(Pids, Ref).

do_f(Parent, Ref, F, I) ->
    Parent ! {self(), Ref, (catch F(I))}.

gather([Pid|T], Ref) ->
    receive
	{Pid, Ref, Ret} ->
	    [Ret|gather(T, Ref)]
    end;
gather([], _) ->
    [].

    %% L = lists:map(fun(X) -> spawn(fun() -> S ! {self(), F(X)} end) end, Ls),
    %% lists:map(fun(Pid) -> 
    %% 		      receive 
    %% 			  {Pid, Res} -> Res
    %% 		      end
    %% 	      end, L).
    
run(N) ->
    X = floor(math:pow(10, N)),
    L = lists:map(fun(_) -> floor(rand:uniform() * X) end, lists:seq(1, X)),
    pmap(fun fact/1, L).
    %% timer:tc(pmap, pmap, [fact, L]).
    %% io:format("~w~n", [timer:tc(pmap, pmap, [fact, L])]).
