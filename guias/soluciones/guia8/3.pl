menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X,X).

menorOIgualFix(X,X).
menorOIgualFix(X, suc(Y)) :- menorOIgualFix(X, Y).

/* 
    La implementación de la guía se cuelga si mandamos menorOIgual(0, X). Esto sucede porque como X es una variable, unifica siempre con suc(Y) y siempre llama de la misma forma, es decir, menorOIgual(0, Y), menorOIgual(0, Y1), menorOIgual(0, Y2) y nunca llega a un caso base.

    La solución acá es que el caso base obligue a que el segundo argumento unifique con el primero para ser menor o igual, entonces podemos ir llamando recursivamente si no unificó con el CB. y decrementar el valor de Y.
    Por defecto, Y se decrementará hasta el caso base (cero) y si llegase a suceder que X es mayor que cero entonces quedará algo como menorOIgual(suc(X), cero) y como es mundo cerrado da false porque cero ya no unifica con la ecuación recursiva, solo con el caso base y no es verdad que suc(X) unifique con cero, son dos constructores distintos (clash).
*/