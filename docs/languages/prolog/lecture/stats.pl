% stats.pl

%
% Calculates the sum of the numbers on a list.
%
sum([], 0).             % base case
sum([X|Xs], Total) :-   % recursive case
    sum(Xs, T),
    Total is X + T.     % always use "is" for arithmetic

%
% Write a predicate that calculates the average of the numbers
% on a list.
%
mean(Lst, Avg) :-
    sum(Lst, Total),
    length(Lst, N),
    Avg is Total / N.


%
% Calculates the min of two values, X and Y.
%
min(X, Y, X) :- X =< Y.  % =< is less than or equal to
min(X, Y, Y) :- X > Y.

%
% Write a predicate that calculates the smallest number on
% a list of numbers.
%
min_list([X], X).
min_list([X|Xs], Min) :-
    min_list(Xs, Y),
    min(X, Y, Min).
