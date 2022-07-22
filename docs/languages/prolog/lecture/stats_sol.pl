% stats_sol.pl

sum([], 0).             % base case
sum([X|Xs], Total) :-   % recursive case
    sum(Xs, T),
    Total is X + T.     % always use "is" for arithmetic

mean(X, Avg) :- 
    sum(X, Total), 
    length(X, N), 
    Avg is Total / N.

min(X, Y, X) :- X =< Y.  % =< is less than or equal to
min(X, Y, Y) :- X > Y.

min_list([X], X).               % base case
min_list([First|Rest], Min) :-  % recursive case
    min_list(Rest, Rmin), 
    min(First, Rmin, Min).
