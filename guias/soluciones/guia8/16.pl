% En este ejercicio particular el cut nos sirve para que una vez que encontremos un X que satisface que es frutal(X) y cremoso(X) después no lo cambie más. Esto es porque sino, tendríamos soluciones como frutilla, banana y banana frutilla que son exactamente lo mismo. 
% Entonces, la idea es decir, si encontraste un X que vale leGusta(X) entonces, buscá todas las combinaciones que haya con todos los posibles Y pero no cambies más el X. Esto sirve porque esencialmente todos los leGusta(X) al fijar la X, solo queda ver con cuales se puede combinar de Y. Y nada más. Si las soluciones intercaladas fuesen diferentes, entonces el cut no tendria sentido acá. 
% En español, podemos leerlo como: "no vuelvas en la regla de cucurucho, más atrás del cut. Solo hacé backtracking hasta los literales desde el ! en adelante."
frutal(frutilla).
frutal(banana).
frutal(manzana).
cremoso(banana).
cremoso(americana).
cremoso(frutilla).
cremoso(dulceDeLeche).

leGusta(X) :- frutal(X), cremoso(X).
cucurucho(X,Y) :- leGusta(X), !, leGusta(Y).