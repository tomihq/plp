padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X, Z), padre(Z, Y).
hijo(X,Y) :- padre(Y, X).
hermano(X,Y) :- hijo(X, Z), hijo(Y, Z), X \= Y. /* si X \= Y lo pongo al pricnipio no vale porque si Y no estaria instanciada - enviada por parametro fallaria porque ej: hermano(juan, Y) no unifica juan con Y */ 
descendiente(X,Y) :- hijo(X,Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y).    