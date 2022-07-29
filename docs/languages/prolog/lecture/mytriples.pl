is_triple(A, B, C) :-
	D is C*C - A*A - B*B,
	D = 0.

% generate and test

solve_triple(A, B, C, N) :-
	between(1, N, A),
	between(1, N, B),
	A =< B,
	between(1, N, C),
	B =< C,
	is_triple(A,B,C).
