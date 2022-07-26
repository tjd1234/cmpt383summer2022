% bits.pl

bit(0).
bit(1).


%
%  |
%  |
%  |
%  |
% \|/
%  v
%














































nbits(1, [B]) :-     % base case
  bit(B).
nbits(N, [B|Bs]) :-  % recursive case
  N > 1, 
  bit(B), 
  N1 is N - 1, 
  nbits(N1, Bs).
