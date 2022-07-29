trit(0).
trit(1).
trit(2).

%% nbits(3, Bits).
%% Bits = [0,0,0],
%% Bits = [0,0,1],

ntrits(1, [B]) :- trit(B).
ntrits(N, [B|Bs]) :-
	N > 1,
	trit(B),
	N1 is N - 1,
	ntrits(N1, Bs).
