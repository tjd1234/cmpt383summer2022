% member_examples

sum_to_5(X, Y) :-
	member(X, [1,2,3,4,5]),
	member(Y, [1,2,3,4,5]),
	Sum is X + Y,
	5 = Sum.




mem(X, [X|_]).
mem(X, [_|Rest]) :-
	mem(X, Rest).
