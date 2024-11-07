padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X, Z), padre(Z, Y).
hijo(X,Y) :- padre(Y, X). /*X es hijo de... */

/*i) ¿Cual es el resultado de la consulta abuelo(X, manuel)?
Recordemos que Prolog va pasando por cada ecuación, y cuando entra a un matcheo hace backtracking y sigue evaluando las separaciones por ",". 

Lo que haría es lo siguiente: 
abuelo(X, manuel), evalúa en todas las definiciones de padre pero como no matchea, no le queda otra que usar la ecuación de abuelo(X,Y).
En este caso, Y toma el valor de manuel, por lo tanto tenemos
abuelo(X, manuel) :- padre(X, Z), padre(Z, manuel)
Como la primera ecuación no tiene ningún tipo de restricción, es decir, ambas variables no están instanciadas, hará match con todos los posibles casos. Entonces se nos abren 7 posibles ramas.
    1. padre(X,Z) :- padre(juan, carlos) como resolvió la primera ecuación, ahora falta padre(Z,manuel). En este caso, Z toma el valor de carlos. Por lo tanto buscaría un matcheo de padre(carlos, manuel). Como no hace match con ninguna de las 7 definiciones, termina y da falso esta rama. Hace BT y vuelve a buscar otra rama para ver si sirve.
    2. padre(X,Z) :- padre(juan, luis) como resolvió la primera ecuación, ahora falta padre(Z, manuel). En este caso, Z toma el valor de luis. Por lo tanto buscaría un matcheo de padre(luis, manuel) y esta ecuación si hace match con una de las definiciones. Por lo tanto, la respuesta sería Juan. Si quisieramos seguir buscando candidatos, haría BT, evaluaría la rama 3 y las demás hasta agotar todas las opciones.
...
Luego, la única respuesta posible es X = juan; 

*/