% last(?L, ?U) %
/* Da true sí y solo sí existe una unificación de lista tal que Lista + U = L. Append es un nombre feo, en realidad es concat. */
last(L, U) :- append(_, [U], L).

% reverse(+L, ?R) %
reverseL([], []).
reverseL(L, [X | R]) :- append(S, [X | _], L), reverse(S, R).

% prefijo(?P, +L) %
/* Da true si y solo sí P es un prefijo de P. La idea es que ?P + cualquierCosa = L*/
prefijo(P, L) :- append(P, _, L).

%sufijo(?S, +L) %
sufijo(S, L) :- append(_, S, L). 

%sublista(?S, +L) donde S es sublista de L
sublista(S, L) :- sufijo(S1, L), prefijo(S, S1).

%pertenece(?X, +L)%
%Podemos validar si X es la cabeza de algún sufijo. [1, 2, 3, 4] -> [], [4], [3, 4], [2, 3, 4], [1, 2, 3, 4]%
pertenece(X, L) :- sufijo(S1, L), S1 \= [], S1 = [X | _].

perteneceB(X, L) :- append(S, [X |_], L]. 
