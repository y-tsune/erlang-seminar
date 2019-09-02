-module(map).
-export([map/2]).

map([], _) ->
    [];
map([X | Xs], F) ->
    [F(X) | map(Xs, F)].
