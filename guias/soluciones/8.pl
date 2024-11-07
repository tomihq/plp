padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X, Z), padre(Z, Y).
hijo(X,Y) :- padre(Y, X).
hermano(X,Y) :- hijo(X, Z), hijo(Y, Z), X \= Y. /* Tengo que garantizar que uno NO es hermano de si mismo. */
descendiente(X,Y) :- hijo(X,Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y).    