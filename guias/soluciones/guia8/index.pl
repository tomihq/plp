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

% menor(+X, +Y, ?Z) %
menor(X, Y, Z) :- X < Y, Z is X. 
menor(X, Y, Z) :- X > Y, Z is Y. 

% suma(+X, +Y, ?Z) %
suma(X, Y, Z) :- Z is X+Y.

% resta(+X, +Y, ?Z) %
resta(X, Y, Z) :- Z is X-Y.

% Sumar X con Y, restar con Z y devolver el resultado%
sumaResta(X, Y, Z, H) :- suma(X, Y, C), resta(C, Z, H).

% borrarDuplicados(+L, ?R) % 

% Aplanar una lista [[1, 2], a, [b, c]]. El caso base es necesario porque sino va a hacer aplanar([], R) y es mentira que la lista que voy armando al final va a ser vacia. %
aplanar([], []).
aplanar([H | T], [H | R]) :- not(is_list(H)), aplanar(T, R). %[1 | []]%
aplanar([H | T], R) :- is_list(H), aplanar(H, Z), aplanar(T, Z2), append(Z, Z2, R). %[[1], 2]%

