% sendmore.pl

alpha1([S, E, N, D, M, O, R, Y], Send, More, Money) :-
    between(1, 9, S),
    between(0, 9, E), S \= E,
    between(0, 9, N), \+ member(N, [S,E]),       % \+ means "not"
    between(0, 9, D), \+ member(D, [S,E,N]),
    between(1, 9, M), \+ member(M, [S,E,N,D]),
    between(0, 9, O), \+ member(O, [S,E,N,D,M]),
    between(0, 9, R), \+ member(R, [S,E,N,D,M,O]),
    between(0, 9, Y), \+ member(Y, [S,E,N,D,M,O,R]),
    Send  is           S*1000 + E*100 + N*10 + D,
    More  is           M*1000 + O*100 + R*10 + E,
    Money is M*10000 + O*1000 + N*100 + E*10 + Y,
    Money is Send + More.

%
% Simulates addition with carries.
%
% Faster than alpha1.
%
alpha2(S, E, N, D, M, O, R, Y, [S, E, N, D, M, O, R, E, M, O, N, E, Y]) :-
    between(0, 9, D), between(0, 9, E),
    Y is (D + E) mod 10,
    C1 is (D + E) div 10,
    between(0, 9, N), between(0, 9, R),
    E is (N + R + C1) mod 10,
    C2 is (N + R + C1) div 10,
    between(0, 9, O),
    N is (E + O + C2) mod 10,
    C3 is (E + O + C2) div 10,
    between(0, 9, S), between(1, 9, M),
    O is (S + M + C3) mod 10,
    M is (S + M + C3) div 10,
    all_diff([S, E, N, D, M, O, R, Y]).

all_diff([]).
all_diff([X|Xs]) :- \+ member(X,Xs), all_diff(Xs).
