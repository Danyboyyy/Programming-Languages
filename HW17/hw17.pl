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

% === travelTime ===

travelTime(Time) :- 
  A is 4,
  C is A - 1,
  B is 4 * C,
  Time is B + B.

% === cellGames ===

before(X, Y, Solution) :- nth1(X1, Solution, X), nth1(Y1, Solution, Y),	X1 < Y1.

after(X, Y, Solution) :- before(Y, X, Solution).

cellGame(Solution) :- 
  length(Solution, 3),
  member(gohan, Solution),
  member(goku, Solution),
  member(vegeta, Solution),
  before(goku, gohan, Solution),
  after(vegeta, gohan, Solution), !.

% === ages ===

ages(J, L, F, Y) :-
  between(1, 100, J), 
	between(1, 100, L),
	between(1, 100, F),
	J > 12,
	L > 12,
	F > 12,
	all_different([J, L, F]),
	46 is J + L + F,
	between(1, 100, Y),
	85 is J + L + F + (3 * Y),
  J is (F + Y) div 2.

% === gardeningContest ===

gardeningContest(Solution) :- 
  length(Solution, 3),
	L = [1, 2, 3],	
	member(PosB, L),	
	member(PosV, L),
	member(PosG, L),
	PosB > PosV,
	PosB > PosG,
	member([_, PosB, brooke], Solution),
	member([quietness, 3, _], Solution),
	member([vanity, PosV, virginia], Solution),	
	member([goldbrush, PosG, tricia], Solution),
	member([_, 2, tricia], Solution), !.

% === tournament ===

tournament(CA, A, T, R, C) :- 
  CA is 28,
  T is 20,
  between(20, 28, A),
  between(20, 28, R),
  between(20, 28, C),
  CA is C + 5,
  C > R,
  C > T,
  C < A,
  CA is 2 * (R - T) + A.

% === zebra ===

right(X, Y, L) :- append(_, [X, Y|_], L).
next(X, Y, L):- right(X, Y, L) ; right(Y, X, L).

zebra(Solution) :- 
  length(Solution, 5),
  member([english, _, _, _, red], Solution),
  member([spanish, dog, _, _, _], Solution),
  member([_, _, _, coffee, green], Solution),
  member([ukranian, _, _, tea, _], Solution),
  next([_, _, _, _, green], [_, _, _, _, white], Solution),
  member([_, snake, winston, _, _], Solution),
  member([_, _, kool, _, yellow], Solution),
  Solution = [_, _, [_, _, _, milk, _], _, _],
  Solution = [[norwegian, _, _, _, _], _, _, _, _],
  next([_, _, chesterfield, _, _], [_, fox, _, _, _], Solution),
  next([_, horse, _, _, _], [_, _, kool, _, _], Solution),
  member([_, _, lucky, juice, _], Solution),
  member([japonese, _, kent, _, _], Solution),
  next([norwegian, _, _, _, _], [_, _, _, _, blue], Solution),
  member([_, zebra, _, _, _], Solution),
  member([_, _, _, water, _], Solution), !.

start :-
	write("% === travelTime ==="), nl, 
	travelTime(Time), % 24
	write(Time), nl,
	write("% === cellGames ==="), nl, 
	cellGame(Order), % [goku,gohan,vegeta]
	write(Order), nl,
	write("% === ages ==="), nl, 
	ages(J, L, F, Y), % [14,17,15,13]
	Names = [J, L, F, Y], 
	write(Names), nl,
	write("% === gardeningContest ==="), nl, 
	gardeningContest(Results),
	write(Results), nl,
	write("% === tournament ==="), nl, 
	tournament(CruzAzul, America, Tigres, Rayados, Chivas), % [28,24,20,22,23]
	Teams = [CruzAzul, America, Tigres, Rayados, Chivas],
	write(Teams), nl,
	write("% === zebra ==="), nl, % [[norwegian,fox,kool,water,yellow],[ukrainian,horse,chesterfield,tea,blue],[english,snake,winston,milk,red],[japonese,zebra,kent,coffee,green],[spanish,dog,lucky,juice,white]]
	zebra(Solution),
	write(Solution), nl, !.