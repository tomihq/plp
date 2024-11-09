padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).

/* abuelo(?X, ?Y) */ 
abuelo(X,Y) :- padre(X, Z), padre(Z, Y).

/* hijo(?X, ?Y) */
hijo(X,Y) :- padre(Y, X).

/* hermano(?X, ?Y) */ 
hermano(X,Y) :- hijo(X, Z), hijo(Y, Z), X \= Y. /* si X \= Y lo pongo al pricnipio no vale porque si Y no estaria instanciada - enviada por parametro fallaria porque ej: hermano(juan, Y) no unifica juan con Y */ 

/* descendiente(?X, ?Y) */
descendiente(X, Y) :- hijo(X,Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y).    

/* 
ii) X es descendiente de Y si y solo si: X es hijo de Y, o 
descendiente: ¿Es Daniel descendiente de Juan? Sí.
descendiente(daniel, juan) espero true.
Dada esa entrada, hace match con la primera ecuación de descendiente(X,Y) y evalúa hijo(X,Y), esto quiere decir que va a fijarse si daniel es hijo directo de juan. Como esto no pasa porque no hay ningun hecho que digan que tienen una relacion padre a hijo, estas 7 opciones no vale ninguna. Hace BT y va a la segunda ecuación.
La idea ahora sería buscar el camino para buscar en base a Daniel: su padre, y en base a su padre, de quien es descendiente recursivamente.
Entonces descendiente(daniel, juan) primero busca e instancia todos los Z posibles para hijo(daniel, Z), es decir esto buscaría padre(Z, daniel) por lo cual de los 7 hechos disponibles, solo instancia un posible Z que seria Z = carlos.
Haciendo backtracking, sale de hijo(X,Z) y ahora va por la ecuacion de descendiente(carlos, juan), hace el llamado recursivo y cae en la primera ecuacion con hijo(carlos, juan), es cierto que Juan es padre de Carlos?, por el hecho 1 sí, es verdadero. Por lo tanto, la respuesta final es que Daniel es Descendiente de Juan y los valores que fue tomando el árbol fueron: X = daniel, Y = juan, Z = carlos.
A su vez, si solamente instanciamos la X con daniel, el resultado será carlos por padre directo, o juan por abuelo.

iii) descendiente(Alguien, juan)
descendiente es un Predicado de Aridad 2. La variable Alguien no está instanciada, por lo tanto, lo que estará buscando esta consulta es todos los que le siguieron a Juan. Es decir, Juan padre de Manuel, Manuel padre de Lauti, y Lauti padre de Matias entonces si me piden descendiente(Alguien, juan) me devolvería Manuel (hijo directo de Juan), también Lauti y Matías.
En este caso los resultados van a ser: carlos, luis, daniel, diego, pablo, manuel y ramiro. Que es la descendencia que tuvo juan.
El árbol en sí es bastante extenso, pero lo voy a poner acá por pasos.
Al llamar el procedimiento, hace match con la primera ecuación
*/
