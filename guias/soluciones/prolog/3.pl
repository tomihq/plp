natural(0).
natural(suc(X)) :- natural(X).
menorOIgual(X, X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

/*
    Los casos infinitos pasan porque Prolog resuelve de arriba hacia abajo tomando la primera regla de la izquierda. Entonces los loops infinitos vienen de que la rama izquierda se hace infinita y por lo tanto no puede cortar nunca.

    Entonces la idea es colocar los casos base arriba, para que tome siempre como primera opción los casos que cortan, y caso contrario, evalue la otra.
    
    Los casos base siempre deben estar al principio.
    
    Un numero es menor igual a otro si descomponiendo el numero mas grande llegamos al mas chico. 
*/