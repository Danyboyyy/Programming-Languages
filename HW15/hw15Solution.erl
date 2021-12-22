-module(hw15Solution).
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

append(X) -> 
	receive
		N when is_number(N) and (N > 0) -> append(X ++ [N]);
		_ -> io:format("~p~n", [X])		
	end.

test01() -> 
	io:format("=== append ===~n"),
	Pid = spawn(hw15Solution, append, [[]]),
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
		{Pid, SenderColor, Message} -> 
		if 
			SenderColor == Color -> io:format("I received a message from a friend (~p): ~p.~n", [Pid, Message]);			
			true -> ok
		end,
		friend(Color)
	end.

test02() -> 
	io:format("=== friend ===~n"),
	P1 = spawn(hw15Solution, friend, [red]),
	P2 = spawn(hw15Solution, friend, [green]),
	P3 = spawn(hw15Solution, friend, [blue]),	
	P4 = spawn(hw15Solution, friend, [green]),
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

marco(PoloPid, Xm, Ym) ->		
	PoloPid ! {self(), Xm, Ym},
	receive
		{_, {DeltaX, DeltaY}} -> 
			X = Xm + DeltaX,
			Y = Ym + DeltaY,			
			if
				(DeltaX == 0) and (DeltaY == 0) -> PoloPid ! terminate;
				true -> io:format("Marco moves to (~p, ~p)~n", [X, Y]), marco(PoloPid, X, Y)		
			end
	end.

polo(X, Y) ->
	if 
		(X == -1) and (Y == -1) -> Xp = rand:uniform(20), Yp = rand:uniform(20);
		true -> Xp = X, Yp = Y
	end,
	receive
		{Pid, Xm, Ym} -> 			
			Pid ! {self(), getDeltas(Xm, Ym, Xp, Yp)},
			polo(Xp, Yp);
		terminate -> io:format("Marco found me! I was hiding at position (~p, ~p).~n", [Xp, Yp])
	end.

getDeltas(Xm, Ym, Xp, Yp) -> 
	if
		Xm < Xp -> Xmove = 1;
		Xm == Xp -> Xmove = 0;
		true -> Xmove = -1
	end,
	if
		Ym < Yp -> Ymove = 1;
		Ym == Yp -> Ymove = 0;
		true -> Ymove = -1
	end,
	{Xmove, Ymove}.

test03() ->
	Xm = rand:uniform(20),
	Ym = rand:uniform(20),			
	io:format("Marco starts at position (~p, ~p)~n", [Xm, Ym]),	
	io:format("Polo is hidden (we do not know where he is)...~n"),
	PoloPid = spawn(hw15Solution, polo, [-1, -1]),
	spawn(hw15Solution, marco, [PoloPid, Xm, Ym]),
	ok.

% === bank ===

update(_, _, [], _) -> [];
update(Id, deposit, [{X, Y} | Z], Amount) -> if  
		(Id == X) and (Amount >= 20) -> [{X, Y + Amount} | Z];
		true -> [{X, Y} | update(Id, deposit, Z, Amount)]
	end;
update(Id, withdraw, [{X, Y} | Z], Amount) -> if  
		(Id == X) and (Amount >= 1) and (Y - Amount >= 0) -> [{X, Y - Amount} | Z];
		true -> [{X, Y} | update(Id, deposit, Z, Amount)]
	end.

bank(Accounts) -> 
	receive
		{open, Id, Amount} when Amount >= 0 -> bank(Accounts ++ [{Id, Amount}]);
		{deposit, Id, Amount} when Amount >= 0 -> bank(update(Id, deposit, Accounts, Amount));
		{withdraw, Id, Amount} when Amount >= 0 -> bank(update(Id, withdraw, Accounts, Amount));
		print -> io:format("Accounts: ~p\n", [Accounts]), bank(Accounts);
		close -> io:format("Bank closed.\n")
	end.

test04() -> 
	Bank = spawn(hw15Solution, bank, [[]]),
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