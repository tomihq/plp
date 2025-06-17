zombie(juan).
zombie(valeria).

tomo_mate_despues(juan,carlos).
tomo_mate_despues(clara,juan).

infectade(ernesto).
infectade(X):-zombie(X).
infectade(X):-zombie(Y),tomo_mate_despues(Y,X).

natural(cero).
natural(suc(X)) :- natural(X).

mayorADos(X) :- natural(suc(suc(suc(X)))).

esPar(cero).
esPar(suc(suc(X))) :- esPar(X).

menor(cero, suc(X)).
menor(suc(X), suc(Y)) :- menor(X, Y).