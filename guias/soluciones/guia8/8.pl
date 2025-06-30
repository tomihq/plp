%parteQueSuma(+L, +S, -P): Es medio un problema de la mochila. Si tengo espacio agrego, caso contrario no.

parteQueSuma([], 0, []).
parteQueSuma([X | XS], S, [X | P]) :- X =< S, S2 is S-X, parteQueSuma(XS, S2, P). % Tengo espacio y lo agarro
parteQueSuma([X | XS], S, P) :- X =< S, parteQueSuma(XS, S, P). % Tengo espacio y no lo agarro 
parteQueSuma([X | XS], S, P) :- X > S, parteQueSuma(XS, S, P). % No me da el espacio para agarrarlo. 
