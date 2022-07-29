% map_coloring.pl

%
% allowable colors
%
color(red).
color(green).
color(blue).

%
% Vertices A and B are neighbors if they are adjacent 
% and have different colors
%
neighbor(A, B) :- 
    color(A), 
    color(B), 
    A \= B.

%
% A, B, C, D, E are the cities, and they store colors.
% neighbor(X, Y) means city X is next to city Y.
%
% The sequence of calls to neighbor in the following map
% functions each encodes a map.
%

%
% A, B, C are connected like a triangle.
% Six possible 3-colorings.
%
map1([A, B, C]) :-
    neighbor(A, B),
    neighbor(B, C),
    neighbor(C, A).

%
% A, B, C, D are connected in all possible ways.
% No 3-colorings are possible.
%
map2([A, B, C, D]) :-
    neighbor(A, B), % edges of the graph
    neighbor(B, C),
    neighbor(C, A),
    neighbor(D, A),
    neighbor(D, B),
    neighbor(D, C).

%
% A, B, C, D, E are connected in a loop.
% Many colorings are possible.
%
map3([A, B, C, D, E]) :-
    neighbor(A, B),
    neighbor(B, C),
    neighbor(C, D),
    neighbor(D, E),
    neighbor(E, A).
