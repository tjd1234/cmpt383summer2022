% sudoku4.pl

solution(A, B, C, D,
         E, F, G, H,
         I, J, K, L,
         M, N, O, P) :-
    % row constraints
    permutation([1, 2, 3, 4], [A, B, C, D]),
    permutation([1, 2, 3, 4], [E, F, G, H]),
    permutation([1, 2, 3, 4], [I, J, K, L]),
    permutation([1, 2, 3, 4], [M, N, O, P]),

    % column constraints
    permutation([1, 2, 3, 4], [A, E, I, M]),
    permutation([1, 2, 3, 4], [B, F, J, N]),
    permutation([1, 2, 3, 4], [C, G, K, O]),
    permutation([1, 2, 3, 4], [D, H, L, P]),

    % sub-square constraints
    permutation([1, 2, 3, 4], [A, B, E, F]),  % upper left
    permutation([1, 2, 3, 4], [C, D, G, H]),  % upper right
    permutation([1, 2, 3, 4], [I, J, M, N]),  % lower left
    permutation([1, 2, 3, 4], [K, L, O, P]).  % lower right


sudoku(A, B, C, D,
       E, F, G, H,
       I, J, K, L,
       M, N, O, P) :-
    solution(A, B, C, D,
             E, F, G, H,
             I, J, K, L,
             M, N, O, P),
    nl, 
    write('A solution to this puzzle is'), 
    nl,
    printrow(A, B, C, D), 
    printrow(E, F, G, H),
    printrow(I, J, K, L), 
    printrow(M, N, O, P).
    
printrow(P, Q, R, S) :- 
    write(' '), write(P), write(' '), write(Q),
    write(' '), write(R), write(' '), write(S), nl.

%% ?- sudoku(
%% |    1, 4, _, _,
%% |    _, _, 4, _,
%% |    2, _, _, _,
%% |    _, _, _, _
%% |    ).
