% ====================
% Complete the following programs and submit your file to Canvas.
% ====================
% Do not change the names of the programs. 
% Do not change the number of elements in the clauses.
% If your file cannot be loaded by the Prolog interpreter, your submission may be cancelled. 
% Then, submit only code that works.
% ====================
% Grading instructions:
% There is a series of test cases for each program. In order to state that your program
% "works as described", your output must be similar to the expected one in each case.

:- use_module(library(bounds)).

% === findNumber ===

findNumber(Number) :-
	between(100, 999, Number),
  0 is (Number + 7) rem 7,
  0 is (Number + 8) rem 8,
  0 is (Number + 9) rem 9, !.


% fishing(Solution) :-
  % length(Solution, 4),

jump(G, A, D, R, J) :-
  L = [9, 12, 17, 20, 25],
  member(G, L),
  member(A, L),
  member(D, L),
  member(R, L),
  member(J, L),
  G is A - 8,
  37 is D + R,
  J is D + 8,
  3 is abs(G - D),
  A is D + 5, !.

sub(S, E, V, N, I, G, H, T) :-
  between(0, 9, S),
  between(0, 9, E),
  between(0, 9, V),
  between(0, 9, N),
  between(0, 9, I),
  between(0, 9, G),
  between(0, 9, H),
  between(0, 9, T),
  (X2 is 0; X2 is 1),
  N is (T + E) mod 10,
  X2 is (T + E) div 10,
  E is (H + N + X2) mod 10,
  X3 is (H + N + X2) div 10,
  V is (G + I + X3) mod 10,
  X4 is (G + I + X3) div 10,
  E is (N + I + X4) mod 10,
  X5 is (N + I + X4) div 10,
  S is E + X5, 
  all_different([S, E, V, N, I, G, H, T]), !.

edge(a, c, 1).
edge(c, b, 1).
edge(c, d, 1).
edge(c, e, 1).
edge(b, e, 1).
edge(d, e, 1).
edge(d, f, 1).
edge(e, g, 1).
edge(e, h, 1).
edge(f, b, 1).
edge(g, h, 1).

path(X, Y, [X, Y], W, Num) :- edge(X, Y, W), W + 1 >= Num.
path(X, Y, [X | Z1], W, Num) :- edge(X, T, W1), path(T, Y, Z1, W2, Num), W is W1 + W2,  W + 1>= Num.

start :-
	write("% === travelTime ==="), nl, 
	findNumber(Number),
	write(Number), nl,
  %write("% === fishing ==="), nl, 
	%fishing(Solution),
	%write(Solution), nl,
  write("% === jump ==="), nl, 
	jump(Gary, Arnie, Danielle, Ruth, Jan),
	Jumps = [Gary, Arnie, Danielle, Ruth, Jan],
	write(Jumps), nl,
  %write("% === sub ==="), nl, 
	%sub(S, E, V, N, I, G, H, T),
	%Solution = [S, E, V, N, I, G, H, T],
	%write(Solution), nl,
  write("% === path ==="), nl, 
	path(a, h, PathAH, CostAH, 4),
	write(PathAH), write(", "), write(CostAH), nl, !.