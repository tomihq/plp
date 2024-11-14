estudiante(tomas).
estudiante(angel).
notas([(tomas, tda, 3), (tomas, plp, 10), (angel, plp, 3), (angel, plp, 10)]).
/* aca como tieneMateriaAprobada E y M estan instanciados member((tomas, plp, Nota), [()...]) unifica con [(tomas, plp, 10)] y luego chequea que esa unificacion de tomas, plp tenga nota >=4 */
tieneMateriaAprobada(E, M) :- estudiante(E), notas(XS), member((E, M, Nota), XS), Nota >= 4.

eliminarAplazos([], []). 
eliminarAplazos([(E, M, N) | XS], [(E, M, N) | Res]) :- N >= 4, eliminarAplazos(XS, Res).
eliminarAplazos([(E, M, N) | XS], Res) :- N < 4, not(tieneMateriaAprobada(E, M)), eliminarAplazos(XS, Res).
eliminarAplazos([(E, M, N) | XS], Res) :- N < 4, tieneMateriaAprobada(E, M), eliminarAplazos(XS, Res).

notasDeAlumno(_, [], []).
notasDeAlumno(E, [(E, _, N) | XS], [N | Res]) :- notasDeAlumno(E, XS, Res).
notasDeAlumno(E, [(E2, _, N) | XS], Res) :- E\=E2, notasDeAlumno(E, XS, Res).

promedio(E, P) :- estudiante(E), notas(XS), eliminarAplazos(XS, Res), notasDeAlumno(E, Res, Res2), sum_list(Res2, Res3), length(Res2, Res4), P is Res3 / Res4.