-module(pmap).
-export([pmap/2, fact/1, run/1, runp/1]).

fact(0) ->
    1;
fact(X) ->
    X * fact(X-1).

pmap(F, Ls) ->
%% 
%% 
%% 
%% 
%% 


runp(N) ->
    L = lists:seq(1, N),
    timer:tc(pmap, pmap, [fun(X)->fact(X)end, L]).

run(N) ->
    L = lists:seq(1, N),
    timer:tc(lists, map, [fun(X)->fact(X)end, L]).

