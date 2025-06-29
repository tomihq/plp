/* A is B: B debe estar instanciado. Se unifica A con el resultado de la operación aritmética B. Si A está instanciado entonces verifica que A y B sean iguales. Si A no está instanciado, al ser una variable, te dice que necesita ser A para unificar con B. */
/* sumar(+A, +B, ?C) */
sumar(A, B, C) :-  C is A + B.

/* resta(+A, +B, ?C) */
resta(A, B, C) :- C is A - B. 

/* Queremos sumar A con B y restarle C */
/* sumarRestar(+A, +B, +C, ?E) */
sumarRestar(A, B, C, E) :- sumar(A, B, D), resta(D, C, E).

/* Nótese que como sumar y restar requieren de que A y B estén instanciados, si no mandamos a sumarRestar ni A ni B ni C nos dará error. */
/* Quiero hacer reversible sumar en sus dos argumentos, es decir sumar(A, 10, 15) deberia dar A = 5. sumar(10, B, 15) debería dar B = 5. */
/* Tenemos varios casos:  Si A está instanciado y C también entonces definimos B como la resta entre C y A. Si B está instanciado y C también, entonces definimos A como entre la resta entre C y B. Si A está instanciado y B también caemos en el caso de ahora. */ 
%sumarReversible(?A, +B, ?C) o sumarReversible(+A, ?B, ?C). Podríamos hacerlo con un desde para generar todos los números que se instancian en C.
sumarReversible(A, B, C) :- nonvar(A), nonvar(B), C is A+B.
sumarReversible(A, B, C) :- nonvar(A), nonvar(C), var(B), B is C-A. 
sumarReversible(A, B, C) :- nonvar(B), nonvar(C), var(A), A is C-B.

/* Queremos el menor entre los dos numeros. Ambos están están instanciados. No son dos numeros iguales. */
%menor(+X, +Y, ?Z)
menor(X, Y, Z) :- X < Y, Z is X.  
menor(X, Y, Z) :- X > Y, Z is Y.

/* Queremos generar todos los números menores a otro. */
menoresA(X, Y) :- between(0, X, Y).

/* Eliminar repeticiones. Usualmente aceptamos repetidos cuando son cosas como listas que tienen elementos repetidos. 
Queremos organizar los empleados de una empresa, y hay varias personas que tienen el mismo rol. Se pide listar las personas que trabajan en la compañía.
*/

ceo(martin).
cto(tomas).
techlead(tomas).
frontarchitect(thiago).
marketing(veronica).

ceos([X]) :- ceo(X).
ctos([X]) :- cto(X).
techleads([X]) :- techlead(X).
frontarchitects([X]) :- frontarchitect(X).
marketings([X]) :- marketing(X).

members(Z) :-  ceos(Ceos),
    ctos(Ctos),
    techleads(Techs),
    frontarchitects(Fronts),
    marketings(Marketing),
    append(Ceos, Ctos, T1),
    append(T1, Techs, T2),
    append(T2, Fronts, T3),
    append(T3, Marketing, R),
    sinRepetidos(R, Z).

sinRepetidos([], []).
sinRepetidos([H | T], Z) :-  sinRepetidos(T, Z), member(H, Z).
sinRepetidos([H | T], [H | Z]) :- sinRepetidos(T, Z), not(member(H, Z)).
/* sinRepetidos([1, 2, 2, 3, 2, 3], Z) */


