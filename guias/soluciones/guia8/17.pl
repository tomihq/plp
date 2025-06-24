% Sean los predicados P(?X) y Q(?X). 
%1. ¿Qué significa la respuesta a la siguiente consulta?: P(Y), not(Q(Y)). 
% La consulta arrojará un Y que satisfaga el predicado P y que falle en el Q(Y). El not es un metapredicado es un operador extra-lógico que tiene éxito cuando su argumento Q(Y) falla. 
%2. ¿Qué pasaría si se invirtiera el orden de los literales en la consulta anterior? Las soluciones podrían no ser del todo correctas. Esto es porque si da la casualidad que lo del adentro del not se cumple, falla para todos y no revisa los demás literales
%3. Sea el predicado P(?X) ¿Como se puede usar el not para determinar que existe una unica Y tal que P(Y) es verdadero? Habría que decir que si existe un X que vale en P(X) no hay otro Y tal que P(Y) vale con X /= Y.

humano(cristiano).
millonario(cristiano).
millonario(messi).
esHumano(X) :- humano(X).

%Queremos encontrar los millonarios que no sean humanos. 
%Mal implementado: Falla (no usar el not adelante porque perdemos soluciones)
noEsHumano(X) :- not(esHumano(X)), millonario(X).

%Bien implementado:
noEsHumano2(X) :- millonario(X), not(esHumano(X)).

% Mostrar unicidad con el not. Existe algo que satisface X y después, NO HAY OTRO Y que satisfaga lo mismo y que SEAN DIFERENTE a X (X es unico).
esUnicoHumano(X) :- esHumano(X), not((esHumano(Y), X \= Y)).
