% practice2.pl

%
% Translate each of the following questions into Prolog. Use
% English words and names to make the facts easy to read.
%
% - Does Mary like John, and John like Mary?
likes(mary, john), likes(john, mary).

% - Do John and Mary like themselves?
likes(john, john), likes(mary, mary).

% - Who likes John and Mary?
likes(X, john), likes(X, mary).

% - Who/what do John and Mary both like?
like(john, X), likes(mary, X).

% - Who does John like that likes Mary?
likes(john, X), likes(X, mary).

% - Who mutually likes each other?
likes(X, Y), likes(Y, X).

%
% Knowledge base for testing.
%
likes(john, mary).
likes(mary, skiing).
likes(john, skiing).
likes(john, flowers).
likes(mary, surprises).
