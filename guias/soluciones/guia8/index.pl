zombie(juan).
zombie(valeria).

tomo_mate_despues(juan,carlos).
tomo_mate_despues(clara,juan).

infectade(ernesto).
infectade(X):-zombie(X).
infectade(X):-zombie(Y),tomo_mate_despues(Y,X).

natural(cero).
natural(suc(X)) :- natural(X).

mayorADos(X) :- natural(suc(suc(suc(X)))).

esPar(cero).
esPar(suc(suc(X))) :- esPar(X).

menor(cero, suc(X)).
menor(suc(X), suc(Y)) :- menor(X, Y).

% menor(+X, +Y, ?Z) %
menor(X, Y, Z) :- X < Y, Z is X. 
menor(X, Y, Z) :- X > Y, Z is Y. 

% suma(+X, +Y, ?Z) %
suma(X, Y, Z) :- Z is X+Y.

% resta(+X, +Y, ?Z) %
resta(X, Y, Z) :- Z is X-Y.

% Sumar X con Y, restar con Z y devolver el resultado%
sumaResta(X, Y, Z, H) :- suma(X, Y, C), resta(C, Z, H).

% juntar(?L1, ?L2, ?L3) que concatena L1 con L2. El caso final recursivo es que la cola sea L2.
juntar([], L2, L2).
juntar([H | T], L2, [H | L3]) :- juntar(T, L2, L3).

% last(?L, ?U) donde U es el ultimo elemento de la lista L
last(L, U) :- append(_, [U], L).

% reverse(+L, ?R), donde R tiene los mismos elementos que L pero en orden inverso.
/* reverse(L, R) :- append(). */

%prefijo(?P, +L), donde P es prefijo de la lista L.
prefijo(P, L) :- append(P, _, L).

%sufijo(?S, +L) donde S es el sufijo de la lista L.
sufijo(S, L) :- append(_, S, L).

%sublista(?S, +L) donde es verdadero si S es sublista de L. Puede ser prefijo, sufijo o literalmente contener los elementos en el mismo orden pero no ser prefijo ni sufijo.

%pertenece(?X, +L) donde es verdadero sii X se encuentra en L.
perteneceEx(E, [E | _]).
perteneceEx(E, [H | T]) :- E \= H, perteneceEx(E, T).

% borrarDuplicados(+L, ?R) % 

% Aplanar una lista [[1, 2], a, [b, c]]. El caso base es necesario porque sino va a hacer aplanar([], R) y es mentira que la lista que voy armando al final va a ser vacia.%
%aplanar(+XS, -YS)%
aplanar([], []).
aplanar([H | T], [H | R]) :- not(is_list(H)), aplanar(T, R). %[1 | []]%
aplanar([H | T], R) :- is_list(H), aplanar(H, Z), aplanar(T, Z2), append(Z, Z2, R). %[[1], 2]%

% interseccion(+L1, +L2, -L3). L3 tiene los elementos de L1 y L2 en el mismo orden sin repetidos. %
interseccion([], _, []).
interseccion([H | T], L2, L3) :-  interseccion(T, L2, L3), not(member(H, L2)). %Si H no está en L2 no hago nada.
interseccion([H | T], L2, Res) :- interseccion(T, L2, L3), member(H, L2), not(member(H, Res)). %Si H ya esta en Res no hago nada.
interseccion([H | T], L2, Res) :- interseccion(T, L2, L3), member(H, L2), not(member(H, L3)), append([H], L3, Res). %Si H está en L2 lo agrego. ¿Acá donde está la condición de que no haya repetidos? ¿será eso lo que me da duplicados? creo que sí. 

% borrar(+L, +X, -Ls)
borrar([], _, []).
borrar([H | T], H, Ls) :- borrar(T, H, Ls).
borrar([H | T], E, [H | Ls]) :- E \=H,  borrar(T, E, Ls). 
/* borrar(L, X, Ls) :- append(L, E, Ls), not(member(X, Ls)). */

vacio(nil).
raiz(bin(I, R, D), R). 

% plego izq y plego der. Cuando llego al final hago 1 + max(AI, AD)
altura(nil, 0).
altura(bin(I, R, D), A) :- altura(I, AI), altura(D, AD), AT is max(AI, AD), A iRs 1 + AT.

% plego izq y plego der. Cuando llego al final sumo las dos ramas, y a su vez, acumulo 1 + AI + AD. La recursion hace el resto con el + 1 + 1 todo el tiempo.
cantNodos(nil, 0).
cantNodos(bin(I, R, D), A) :- cantNodos(I, AI), cantNodos(D, AD), A is 1 + AI + AD.

%iesimo(+I, +L, -X): La idea acá es aprovechar el append. Si vos tenés la lista [1, 2, 3, 4] y te piden I = 3 ¿qué haces? bueno, podés armar una lista que ignore los primeros 3 elementos y agarre el siguiente (recordar que I = 3 sería el cuarto elemento). La declaratividad viene acá desde el lado de: "Creame una lista cualquiera que tenga I elementos", como la lista que tiene "cualquier elemento" va a tratar de unificarla, el append va a decir ah ok, si vos querés que el resultado del append sea la lista original, y me decís que la lista empieza con L1 elementos, entonces te hago append(primerosIElementos, elElementoQueQueres, listaFinal).
%El truco acá además está en entender que length(noInstanciado, instanciado) te da una lista de longitud I que matchea con cualquier cosa
iesimo(I, L, X) :- length(L1, I), append(L1, [X | _], L).

%iesimoReversible(?I, +L, -X): Mismo anterior pero la I puede o no venir instanciada. Para manejar esto vamos a tener dos casos, una cláusula para cuando es var(I) y otra cuando es nonvar(y). Si es variable ¿qué tendría que hacer? El append anterior seguro, solo que cambiaría el length(L1, I) porque el I no está instanciado. 
%¿Cómo deberíamos ir generando la I? Excelente pregunta. Acá el factor fundamental no sería ir instanciando I como algo determinante para arrojar el resultado sino que necesitamos además devolver qué valor toma en cada paso (por cada elemento). 
%Parece que el problema cambia, pero acá es un poquito diferente. 
%La idea acá sería: generar listas que vayan hasta L, tomar, en cada posible unificación la cabeza e instanciar ahí la X. 
%Por otro lado, en qué posición está. En la posición que estaría sería literalmente en el tamaño de la lista que tuviste que agregar como primer parámetro del append (cuantos se tuvo que saltear).
iesimoReversible(I, L, X) :- nonvar(I), length(L1, I), append(L1, [X | _], L).
iesimoReversible(I, L, X) :- var(I), append(L1, [X | _], L), length(L1, I), I>=0.

%desdeHasta(+X, -Y)
% Piense con sus palabras como haría para generar todos los números que van desde X hasta el infinito. La idea es que instancies cada número posible en Y. 
% Sabemos que si o si como input tenemos por ejemplo X = 5, lo que tengo que hacer es literalmente hacer que unifique Y con 5, Y con 6, y así sucesivamente.

desdeHasta(X, X).
desdeHasta(X, Y) :- N is X+1, desdeHasta(N, Y).

%desdeHasta(+X, ?Y).
%Piense, y escriba con sus palabras si el anterior predicado funciona para un Y que está instanciado. ¿Por qué? 
%Si X e Y están instanciados hay dos problemas:
%El primer problema es que solo va a dar true cuando X = Y.
%El segundo problema es que siempre va a unificar en la segunda cláusula X sea igual a Y o no. Y hay un problema, se va a colgar infinitamente porque Y no se usa en ningun lado de la segunda cláusula y va a pasar en un momento que si seguimos pidiendo soluciones (despues de la X = Y) se va a colgar, porque va a tratar de unificar pero nunca para la recursión ¿por qué? porque el caso base es desdeHasta(X, X) pero prolog va a querer probar la recursiva porque va a unificar la cabeza siempre.
%Entonces, tenemos dos casos: cuando Y sea variable y cuando Y no sea variable.
% El caso base va a ser: si Y NO es variable, entonces ambos están instanciados. Si X =< Y es true.
% Si Y es variable, reutilizo el que hicimos antes.
% El cut no es necesario, de hecho, da el mismo resultado pero yo lo puse nomás para que si encontró una solución ni trate de leer la segunda cláusula. Porque aunque parezca chiste, la va a evaluar igual. Porque la primera vez que llamamos dice: ¿qué cláusulas matchea a nivel cabeza? las dos, primero entra por la primera, da el resultado y después hace backtrack y dice ok, me faltó esta que a nivel cabeza unificaba, pero inmediatamente en la segunda muere por el var(Y), no obstante, te ofrece igual "buscar por si acaso". El cut justamente te evita eso, que si encontrás una solución como true, si le ponés el ! no volvés de esa cláusula, no salís. Esto último es re común, y aunque no esté el cut la solución es válida porque no hay forma de decirle de antemano (si no se lo podés decir a nivel cabeza de regla, acá no entrés). En prolog no se permite lógica en la cabeza de la cláusula, solo patrones/unificaciones

desdeHastaReversible(X, Y) :- nonvar(Y), X =< Y, !.
desdeHastaReversible(X, Y) :- var(Y), desdeHasta(X, Y).

%pmq(+X, -Y) que genera todos los naturales pares menores o iguales a X. 
%Como X está instanciada, no podemos usar generación infinita como el anterior. Esto es porque, si le decimos generá los pares hasta 10, se pueden contar con los dedos. En el caso del desde (no reversible), eran números desde una cota inferior hacia arriba (infinitos).
%¿Qué es lo que tiene que cumplir la solución? Tiene que haber un literal que me genere todos los números del 2 hasta el X, de esos, me fijo qué numeros son pares, por último lo voy devolviendo en Y. No hace falta hacer recursión sino que, por cada rta del literal va a ir dando las respuestas según corresponda porque los pares no están instanciados. Esto de generar ciertos resultados y después filtrarlos (quedarnos con los pares) se llama generate & test.

pmq(X, Y) :- between(0, X, Y), R is Y mod 2, R is 0.

%coprimos(-X, -Y) que instancia en X e Y TODOS los pares de numeros coprimos. 
%Recordar que dos numeros son coprimos si su maximo comun divisor es 1. 
%% X, Y > 0 (considerar X \=Y rompería el caso del (1, 1)). 
%Algunos ejemplos pueden ser (1, 1), (1, 2), (2, 1), (1, 3), (2, 3), (3,1), (3, 2)
%Nótese que antes de cambiar de nro, es como que buscamos una cota, y despues veo si genero primero todos los de izq en esa cota o todos los de der. Hacés una especie de segundaCoord - primeraCord es 0, filtramos y cambiamos el nro.
%En este caso las soluciones son infinitas. Por las leyes de generación infinita solo usamos un generador (que sea infinito), para generar infinitas soluciones. Creo creo, que la idea es hacer a tender a infinito la segunda coordenada y limitar la primera.
%Osea desdeHasta(1, N). Esto genera N = 1, N = 2, N = 3. Por otro lado hago between(1, N, X).
% Para N = 1 tengo between(1, 1, X) X = 1 Y = 0
% Para N = 2 tengo between(1, 2, X) X = 1, Y = 1. X = 2, Y = 0
% Para N = 3 tengo between(1, 3, X) X = 1, Y = 2. X = 2, Y = 1 (acá esta el bidireccional). between(1, MAX, X), Y = MAX-X

coprimos(X, Y) :- desdeHasta(1, N), paresQueSuman(N, X, Y), X > 0, Y > 0, 1 is gcd(X, Y).

%paresQueSuman(+N, -X, -Y)
paresQueSuman(N, X, Y) :- between(1, N, X), Y is N-X.

%pertenece(?X, +L): que sea verdadero si X está en L.
%append(L1, L2, L3) combina L1 y L2 de la forma que sea para llegar a L3. En este caso necesitamos saber la cabeza de la segunda sublista que al ser concatenada con L2 da L.
pertenece(X, L) :- append(_, [X | _], L).

%reverse(+L, ?R)
reverse([], []).
reverse(L, R) :- append(L1, [U], L), reverse(L1, P), append([U],P, R).

%sublista(?S, +L): Una sublista es un prefijo de algun sufijo.
sublista(S, L) :- append(_, SU, L), append(S, _, SU).
sublista2(S, L) :- sufijo(SU, L), prefijo(S, SU).

%borrar(+L, +X, -LS). Elimina todas las ocurrencias de X en L. Idea: No agregarlo si es igual al que quiero eliminar, appendeo los resultados recursivos.
borrar([], []).
borrar([E | XS], X, LS) :- E 
borrar([X | XS], X, LS) :- borrar(XS, LS). 

%sacarDup(L1, L2): L2 contiene los elementos de L1 pero sin repetidos.
sacarDup([], []).
sacarDup([X | XS], L2) :- member(X, XS), !, sacarDup(XS, L2).
sacarDup([X | XS], [X | R]) :- not(member(X, XS)), sacarDup(XS, R).


