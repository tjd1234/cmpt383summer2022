% length_examples.pl

mylen([], 0).
mylen([_|Xs], Len) :-
	mylen(Xs, Rest_len),
	Len is 1 + Rest_len.
