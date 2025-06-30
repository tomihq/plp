%parteQueSuma(+L, +S, -P): Es medio un problema de la mochila. Si tengo espacio agrego, caso contrario no.

parteQueSuma([], 0, []).
parteQueSuma([X | XS], S, [X | P]) :- X =< S, S2 is S-X, parteQueSuma(XS, S2, P).
parteQueSuma([X | XS], S, P) :- X =< S, parteQueSuma(XS, S, P).
parteQueSuma([X | XS], S, P) :- X > S, parteQueSuma(XS, S, P). 
