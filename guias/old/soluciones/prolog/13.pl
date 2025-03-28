desdeReversible(X, Y) :- var(Y), Y = X. 
desdeReversible(X, Y) :- nonvar(Y), X =< Y. 
desdeReversible(X, Y) :- var(Y), X1 is X + 1, desdeReversible(X1, Y). 

coprimos(X,Y) :- nonvar(X), nonvar(Y), 1 is gcd(X,Y).
coprimos(X, Y) :- desdeReversible(1, S), between(1, S, X), Y is S-X, 1 is gcd(X, Y). 