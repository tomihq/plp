padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).

/* abuelo(+X, +Y) */ 
abuelo(X,Y) :- padre(X, Z), padre(Z, Y).

/* hijo(+X, +) */
hijo(X,Y) :- padre(Y, X).

/* hermano(+X, +Y) */ 
hermano(X,Y) :- hijo(X, Z), hijo(Y, Z), X \= Y. 
/* si X \= Y lo pongo al pricnipio no vale porque si Y no estaria instanciada - enviada por parametro fallaria porque ej: hermano(juan, Y) no unifica juan con Y */ 

/* descendiente(+X, +Y) */
descendiente(X, Y) :- hijo(X,Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y). 

/* nietos(?X, +Y) */
nietos(X,Y) :- hijo(Z, Y), hijo(X, Z).

/* hermanos(-X, +Y) hermanos(-X, pablo) respuesta va en X. z tiene el padre de Y. */
hermanos(X,Y) :- padre(Z, Y), hijo(X, Z), hermano(X, Y).

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
Se asume que cada vez que se pide una respuesta se piden más.
descendiente es un Predicado de Aridad 2. La variable Alguien no está instanciada, por lo tanto, lo que estará buscando esta consulta es todos los que le siguieron a Juan. Es decir, Juan padre de Manuel, Manuel padre de Lauti, y Lauti padre de Matias entonces si me piden descendiente(Alguien, juan) me devolvería Manuel (hijo directo de Juan), también Lauti y Matías.
En este caso los resultados van a ser: carlos, luis, daniel, diego, pablo, manuel y ramiro. Que es la descendencia que tuvo juan.
El árbol en sí es bastante extenso, pero lo voy a poner acá por pasos y cuando esté identado es porque estamos en la misma rama.
Al llamar el procedimiento, hace match con la primera regla: descendiente(Alguien, juan).
El siguiente paso es llamar hijo(Alguien, juan) -= padre(juan, Alguien) y acá hay 7 posibles hechos para tomar:
    1. padre(juan, carlos): vale.
    2. padre(juan, luis): vale
    3, 4, 5, 6, 7 no valen. 

Respuesta Intermedia: Entonces las primeras dos respuestas son carlos, luis.

Hace BT, sale de todas las posibles combinaciones de la primera ecuación y va a la segunda.
descendiente(Alguien, juan) :- hijo(Alguien, Z), descendiente(Z, juan)
Acá se torna todo pesado, porque es una conjunción, donde cada condición (hijo, descendiente) implican descendiente(Alguien, juan).
Como Prolog trabaja, toma la primera ecuación y prueba todos los posibles casos.
hijo(Alguien, Z): Como ni Alguien ni Z están instanciadas, va a prácticamente traer todas las combinaciones posibles.
Esto quiere decir que hijo(Alguien, Z) -= padre(Z, Alguien) traerá:
    1. Z = juan, Alguien = carlos por primer hecho.
    2. Z = carlos, Alguien = daniel
    3. Z = carlos, Alguien = diego
    4. Z = luis, Alguien = pablo
    5. Z = luis, Alguien = manuel
    6. Z = luis, Alguien = ramiro

Ahora, como no tiene nada más que hacer, hace BT y prueba todos los casos para la segunda ecuación.
        2. descendiente(carlos, juan) Z = carlos,  Y = juan
            1. hijo(carlos, juan) -= padre(juan, carlos) esto es Falso.
            2. hijo(carlos, Z), descendiente(carlos, juan)
                1. De la primera de las condiciones nos trae: X = daniel, X = diego
                2. De la segunda condicion descendiente(carlos, juan) y esta se cumple porque carlos es hijo directo de juan.
                Entonces la respuesta intermedia añade: daniel y diego

        Luego lo mismo con luis.


iv) Para conseguir los nietos de Juan, esto quiere decir que estamos buscando todos los posibles descendientes de Juan EXCEPTO sus hijos directos.
nietos(X,juan) ¿qué X son nietos de Juan? 
Primero se buscan los hijos de Juan. Luego, por cada hijo de Juan instanciado, se buscan sus hijos directos.
En este caso, los nietos de juan son los hijos de carlos y luis, es decir: daniel, diego, pablo, manuel y ramiro.

v) Conseguir todos los hermanos de Pablo.
Primero debo buscar su padre, y en base a su padre directo, los hijos de ese padre. El tema es que acá no puede aparecer Pablo por lo tanto podemos hacer que todos los X sean hermanos de un Y particular.
Ej.: Hermanos de Pablo -> Busco Padre -> Luis -> Busco hijos de Luis -> pablo, manuel y ramiro. 
*/