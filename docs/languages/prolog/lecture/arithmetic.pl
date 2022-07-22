% arithmetic.pl

inc(N, N1) :-
	N1 is N + 1.            % arithmetic must be in "is"

to_celsius(F, C) :-
	C is (F - 32) * 5 / 9.  % arithmetic must be in "is"

%
% Write a predicate that calculates the area an perimeter of 
% a square with a given side length.
%
% ?- square(5, A, P).
% A = 25,
% P = 20.
%

square(Side, Area, Perimeter) :-
	Area is Side * Side,
	Perimeter is 4*Side.
