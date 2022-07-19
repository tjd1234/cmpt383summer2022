% family.pl

male(bob).
male(doug).

female(val).
female(ada).

% parents(child, mother, father)
parents(doug, ada, bob).
parents(val, ada, bob).

sister_of(X, Y) :-   % head
	female(X),                 % body
	parents(X, Mother, Father),
	parents(Y, Mother, Father),
	X \= Y.

% \= means "does not unify"