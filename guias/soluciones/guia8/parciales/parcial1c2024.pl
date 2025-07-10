estudiante(juan).
estudiante(maria).
estudiante(nicolas).

nota(juan, plp, 3).
nota(juan, plp, 9).
nota(maria, tlen, 2).
nota(nicolas, tda, 9). 

notas(XS) :- findall((E, M, N), nota(E, M, N), XS).

tieneMateriaAprobada(E, M) :- estudiante(E), notas(XS), member((E, M, N), XS), N>=4.

eliminarAplazos([], []).
eliminarAplazos([E | LS], L) :- E = (NE, M, N), tieneMateriaAprobada(NE, M), N < 4, eliminarAplazos(LS, L). 
eliminarAplazos([E | LS], [E | R]) :- E = (NE, M, N), not(tieneMateriaAprobada(NE, M)), N < 4, eliminarAplazos(LS, R).
eliminarAplazos([E | LS], [E | R]) :- E = (NE, M, N), N >= 4, eliminarAplazos(LS, R).

listaNotasEstudiante([], _, []).
listaNotasEstudiante([NME | LS], E, [N | NE]) :- NME = (E, _, N), listaNotasEstudiante(LS, E, NE).
listaNotasEstudiante([NME | LS], E, NE) :- NME = (E2, _, _), E \= E2, listaNotasEstudiante(LS, E, NE).

promedio(A, P) :- estudiante(A), notas(XS), eliminarAplazos(XS, NSA), listaNotasEstudiante(NSA, A, LNE), sum_list(LNE, S), length(LNE, L), P is S//L.

mejorPromedio(A) :- estudiante(A), promedio(A, P), not((estudiante(B), promedio(B, P2), P2 > P)).