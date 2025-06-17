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

% juntar(?L1, ?L2, ?L3) que concatena L1 con L2. El caso final recursivo es que la cola sea L2.
juntar([], L2, L2).
juntar([H | T], L2, [H | L3]) :- juntar(T, L2, L3).

% last(?L, ?U) donde U es el ultimo elemento de la lista L
last(L, U) :- append(_, [U], L).

% reverse(+L, ?R), donde R tiene los mismos elementos que L pero en orden inverso.
/* reverse(L, R) :- append(). */

%prefijo(?P, +L), donde P es prefijo de la lista L.
prefijo(P, L) :- append(P, _, L).

%sufijo(?S, +L) donde S es el sufijo de la lista L.
sufijo(S, L) :- append(_, S, L).

%sublista(?S, +L) donde es verdadero si S es sublista de L. Puede ser prefijo, sufijo o literalmente contener los elementos en el mismo orden pero no ser prefijo ni sufijo.

%pertenece(?X, +L) donde es verdadero sii X se encuentra en L.
perteneceEx(E, [E | _]).
perteneceEx(E, [H | T]) :- E \= H, perteneceEx(E, T).

% borrarDuplicados(+L, ?R) % 

% Aplanar una lista [[1, 2], a, [b, c]]. El caso base es necesario porque sino va a hacer aplanar([], R) y es mentira que la lista que voy armando al final va a ser vacia.%
%aplanar(+XS, -YS)%
aplanar([], []).
aplanar([H | T], [H | R]) :- not(is_list(H)), aplanar(T, R). %[1 | []]%
aplanar([H | T], R) :- is_list(H), aplanar(H, Z), aplanar(T, Z2), append(Z, Z2, R). %[[1], 2]%

% interseccion(+L1, +L2, -L3). L3 tiene los elementos de L1 y L2 en el mismo orden sin repetidos. %
interseccion([], _, []).
interseccion([H | T], L2, L3) :-  interseccion(T, L2, L3), not(member(H, L2)). %Si H no está en L2 no hago nada.
interseccion([H | T], L2, Res) :- interseccion(T, L2, L3), member(H, L2), not(member(H, Res)). %Si H ya esta en Res no hago nada.
interseccion([H | T], L2, Res) :- interseccion(T, L2, L3), member(H, L2), not(member(H, L3)), append([H], L3, Res). %Si H está en L2 lo agrego. ¿Acá donde está la condición de que no haya repetidos? ¿será eso lo que me da duplicados? creo que sí. 

% borrar(+L, +X, -Ls)
borrar([], _, []).
borrar([H | T], H, Ls) :- borrar(T, H, Ls).
borrar([H | T], E, [H | Ls]) :- E \=H,  borrar(T, E, Ls). 
/* borrar(L, X, Ls) :- append(L, E, Ls), not(member(X, Ls)). */

vacio(nil).
raiz(bin(I, R, D), R). 

% plego izq y plego der. Cuando llego al final hago 1 + max(AI, AD)
altura(nil, 0).
altura(bin(I, R, D), A) :- altura(I, AI), altura(D, AD), AT is max(AI, AD), A is 1 + AT.

% plego izq y plego der. Cuando llego al final sumo las dos ramas, y a su vez, acumulo 1 + AI + AD. La recursion hace el resto con el + 1 + 1 todo el tiempo.
cantNodos(nil, 0).
cantNodos(bin(I, R, D), A) :- cantNodos(I, AI), cantNodos(D, AD), A is 1 + AI + AD.