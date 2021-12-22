-module(hw15).
-export([test01/0, append/1, test02/0, friend/1, test03/0, marco/3, polo/2, test04/0, bank/1]).

% ====================
% Complete the following functions and submit your file to Canvas.
% ====================
% Do not change the names of the functions. 
% Do not change the number of arguments in the functions.
% If your file cannot be loaded by the Erlang compiler, your submission may be cancelled. 
% Then, submit only code that works.
% ====================
% Grading instructions:
% There is a series of test cases for each function. In order to state that your function
% "works as described", your output must be similar to the expected one in each case.

% === append ===

append(Lst) -> 
	receive
		X when is_number(X), X > 0 -> append(Lst ++ [X]);
		_ -> io:format("~p~n", [Lst]), ok
	end.

test01() -> 
	io:format("=== append ===~n"),
	Pid = spawn(hw15, append, [[]]),
	Pid ! 5, 	% Nothing printed on screen.
	Pid ! 10, 	% Nothing printed on screen.
	Pid ! 14, 	% Nothing printed on screen.
	Pid ! x, 	% The process ends and prints [5, 10, 14] on screen.
	Pid ! 5, 	% Nothing happens since the process has already finished.
	ok.			% This is the return value for test01 (it will eventually be printed on screen).

% === friend ===

friend(Color) -> 
	receive		
		{Pid, Message} -> Pid ! {self(), Color, Message}, friend(Color);
		{Pid, ColorOrigen, Message} -> 
		if 
			ColorOrigen == Color -> io:format("I received a message from a friend (~p): ~p.~n", [Pid, Message]);			
			true -> ok
		end,
		friend(Color)
	end.

test02() -> 
	io:format("=== friend ===~n"),
	P1 = spawn(hw15, friend, [red]),
	P2 = spawn(hw15, friend, [green]),
	P3 = spawn(hw15, friend, [blue]),	
	P4 = spawn(hw15, friend, [green]),
	P1 ! {P2, "A la grande le puse cuca."},
	P2 ! {P4, "Hable más fuerte que tengo una toalla."},
	P3 ! {P4, "Tiene todo el dinero del mundo, pero hay algo que no puede comprar... un dinosaurio."},
	P4 ! {P1, "na na na na na na na na, líder."},
	P4 ! {P2, "¿Qué te pasó, viejo? Antes eras chévere."},
	ok.
	% Only two of the phrases are printed on screen (the PID is likely to be different):
	% I received a message from a friend (<0.227.0>): "Hable más fuerte que tengo una toalla.".
	% I received a message from a friend (<0.229.0>): "¿Qué te pasó, viejo? Antes eras chévere.".
	% ok will eventually be printed on screen.

% === marcopolo ===

marco(PoloPid, XPos, YPos) ->		
	PoloPid ! {self(), XPos, YPos},
	receive
		{_, {Hor, Vert}} -> X = XPos + Hor, Y = YPos + Vert,			
			if
				(Hor == 0) and (Vert == 0) -> PoloPid ! bye;
				true -> io:format("Marco moves to (~p, ~p)~n", [X, Y]), marco(PoloPid, X, Y)		
			end
	end.

distancia(X1, Y1, X2, Y2) -> 
	if
		X1 < X2 -> MovX = 1;
		X1 == X2 -> MovX = 0;
		true -> MovX = -1
	end,
	if
		Y1 < Y2 -> MovY = 1;
		Y1 == Y2 -> MovY = 0;
		true -> MovY = -1
	end,
	{MovX, MovY}.

polo(X, Y) ->
	if 
		(X == -1) and (Y == -1) -> RandX = rand:uniform(20), RandY = rand:uniform(20);
		true -> RandX = X, RandY = Y
	end,
	receive
		{Pid, AuxX, AuxY} -> Pid ! {self(), distancia(AuxX, AuxY, RandX, RandY)}, polo(RandX, RandY);
		bye -> io:format("Marco found me! I was hiding at position (~p, ~p).~n", [RandX, RandY])
	end.

test03() ->
	Xm = rand:uniform(20),
	Ym = rand:uniform(20),			
	io:format("Marco starts at position (~p, ~p)~n", [Xm, Ym]),	
	io:format("Polo is hidden (we do not know where he is)...~n"),
	PoloPid = spawn(hw15, polo, [-1, -1]),
	spawn(hw15, marco, [PoloPid, Xm, Ym]),
	ok.

% === bank ===

act(_, _, [], _) -> [];
act(Id, deposit, [{X, Y} | Z], Cant) when Id == X, Cant >= 20 -> [{X, Y + Cant} | Z];
act(Id, deposit, [{X, Y} | Z], Cant) when true -> [{X, Y} | act(Id, deposit, Z, Cant)];
act(Id, withdraw, [{X, Y} | Z], Cant) when Id == X, Cant >= 1, Y - Cant >= 0 -> [{X, Y - Cant} | Z];
act(Id, withdraw, [{X, Y} | Z], Cant) when true ->  [{X, Y} | act(Id, deposit, Z, Cant)].

bank(Cuenta) -> 
	receive
		{open, Id, Cant} when Cant >= 0 -> bank(Cuenta ++ [{Id, Cant}]);
		{deposit, Id, Cant} when Cant >= 0 -> bank(act(Id, deposit, Cuenta, Cant));
		{withdraw, Id, Cant} when Cant >= 0 -> bank(act(Id, withdraw, Cuenta, Cant));
		print -> io:format("Accounts: ~p\n", [Cuenta]), bank(Cuenta);
		close -> io:format("Bank closed.\n")
	end.

test04() -> 
	Bank = spawn(hw15, bank, [[]]),
	Bank ! {open, 100, 3000},			% Creates an account with Id = 100 and $3000.
	Bank ! {open, 200, 5000},			% Creates an account with Id = 200 and $5000.
	Bank ! {open, 300, 12000},			% Creates an account with Id = 300 and $12000.
	Bank ! print,						% Prints the balance of all the accounts on screen.
	Bank ! {deposit, 300, 5000},		% Adds $5000 to account with Id = 300.
	Bank ! {deposit, 100, 15},			% Nothing happens since the minimum amount to deposit is $20.
	Bank ! {withdraw, 200, 1500},		% Withdraws $1500 from the account with Id = 200.
	Bank ! {withdraw, 300, 0.50},		% Nothing happens since the minimum amount to withdraw is $1.
	Bank ! print,						% Prints the current balance of all the accounts: [{100,3000},{200,6500},{300,17000}]
	ok.