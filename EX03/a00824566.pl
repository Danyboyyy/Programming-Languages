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

% === tea ===

tea(P, E, A, T, X) :-
	between(0, 100, P),
  between(0, 100, E),
  between(0, 100, A),
  between(0, 100, T),
  all_different([P, E, A, T]),
  22 is P + E + A,
  42 is P + E + A + T,
  X is T + E + A, !.

% === candy ===

candy(Sa, Su, J) :-
	Sa is 15,
  Su is Sa + (Sa * 2),
  X is ((Sa + Su) div 5) * 8,
  J is (X div 8) * 3, !.

% === ages ===

ages(Bo, Be, T) :-
  between(1, 100, Bo),
  between(1, 100, Be),
  between(1, 100, T),
  T is Bo + Be,
  T is (Bo**3 + Be**3) div T,
  T is (Bo**2 + Be**3) div T, !.

% === houses ===

right(X, Y, L) :- append(_, [X, Y|_], L).
next(X, Y, L):- right(X, Y, L) ; right(Y, X, L).
before(X, Y, Solution) :- nth1(X1, Solution, X), nth1(Y1, Solution, Y),	X1 < Y1.
after(X, Y, Solution) :- before(Y, X, Solution).

houses(Solution) :-
  length(Solution, 4),
  member([_, red], Solution),
  member([_, yellow], Solution),
  member([_, blue], Solution),
  member([_, green], Solution),
  Solution = [_, _, [bruce, _], _],
  member([tony, green], Solution),
  next([peter, _], [bruce, _], Solution),
  \+member([steve, blue], Solution),
  before([steve, _], [peter, _], Solution), 
  (Solution = [[_, red], _, _, _]; Solution = [_, _, _, [_, red]]),
  member([steve, _], Solution), !.

start :-
	write("% === tea ==="), nl, 
	tea(P, E, A, T, X),
  Tea is T + E + A,
	write(Tea), nl,
  write("% === candy ==="), nl, 
	candy(Sanjev, Susan, Jack),
	write(Jack), nl, 
  write("% === ages ==="), nl, 
	ages(Bob, Ben, Tom),
  Ages = [["Bob", Bob], ["Ben", Ben], ["Tom", Tom]],
	write(Ages), nl,
  write("% === houses ==="), nl, 
	houses(Solution),
	write(Solution), !.