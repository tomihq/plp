Exercise 1.1 Which of the following sequences of characters are atoms, which are variables, and which are neither?

vINCENT: átomo
Footmassage: variable
variable23: átomo
Variable2000: variable
big_kahuna_burger: átomo
'big  kahuna  burger': átomo
big  kahuna  burger: neither
'Jules': átomo
_Jules: variable
'_Jules': átomo

Exercise  1.2 Which of the following sequences of characters are atoms, which are variables, which are complex terms, and which are not terms at all? Give the functor and arity of each complex term.

loves(Vincent,mia): término complejo, Vincent es una variable, y mia es un átomo. Aridad 2.
Butch(boxer): no es un término válido.
boxer(Butch): es un término complejo con aridad 1. Butch es una variable. 
and(big(burger),kahuna(burger)): es un término complejo con aridad 2. Depende de otros dos predicados también de aridad 1. burger es un átomo.
and(big(X),kahuna(X)): es un término complejo con aridad 2. big y kahuna son predicados de aridad 1. X es una variable.

Exercise  1.3 How many facts, rules are there in the following knowledge base? What are the heads of the rules, and what are the goals they contain?

woman(vincent).
woman(mia).
man(jules).
person(X):- man(X); woman(X).
loves(X,Y):- father(X,Y).
father(Y,Z):- man(Y), son(Z,Y).
father(Y,Z):- man(Y), daughter(Z,Y).

Hay 3 hechos o axiomas. 4 reglas. 
El HEAD de una regla es el término que está a la izquierda del :- mientras que el BODY son las condiciones que deben cumplirse para que el HEAD sea verdadero.
person(X) es un predicado de aridad 1, es el HEAD y será verdadero sí y solo sí man(X) es verdadero o woman(X) lo es.
loves(X,Y) es un predicado de aridad 2, es el HEAD y será verdadero sí y solo sí father(X,Y) lo es. Este predicado dice que X ama a Y sí y solo sí X es el padre de Y. 
Las últimas dos son similares, la diferencia es que en una verifica que el argumento Y sea un hombre, y luego, se fija si existe un Z tal que es hijo de Y. 
En la otra, se verifica que Y sea un hombre también, y luego se fija si existe un Z tal que es hija de Y. 
En resumidas palabras: Dados un Y, Z la primera te dice si Y es padre de Z si es el hijo, mientras que la otra te dice lo mismo pero es la hija.

Exercise  1.4 Represent the following in Prolog:

Butch is a killer.
Mia and Marsellus are married.
Zed is dead.
Marsellus kills everyone who gives Mia a footmassage.
Mia loves everyone who is a good dancer.
Jules eats anything that is nutritious or tasty.

killer(butch).
married(mia, marsellus).
dead(zed).
good_dancer(X).
gives_footmassage(X, mia).
nutritious(X).
tasty(X).
kills(marsellus, Y) :- gives_footmassage(Y, mia).
loves_everyone(mia, Y) :- good_dancer(Y).
eats(jules) :- nutritious(X); tasty(X)

Exercise  2.1 Which of the following pairs of terms unify? Where relevant, give the variable instantiations that lead to successful unification.

bread  =  bread: unifica 
'Bread'  =  bread: no unifica, no son el mismo átomo. 
'bread'  =  bread: unifica, ambos son el mismo átomo.
Bread  =  bread: no unifica, Bread es una variable, bread es un átomo 
bread  =  sausage: no unifica, son átomos diferentes.
food(bread)  =  bread: no unifica por clash. 
food(bread)  =  X: unifica con X = food(bread)
food(X)  =  food(bread): unifica con X = bread luego de realizar decompose
food(bread,X)  =  food(Y,sausage): unifica con  Y = bread; X = sausage; 
food(bread,X,beer)  =  food(Y,sausage,X): no unifica, X no puede tener dos valores distintos. 
food(bread,X,beer)  =  food(Y,kahuna_burger): no unifica por clash. 
food(X)  =  X: unifica con X = food(X). Sin embargo, hay occurs-check. 
meal(food(bread),drink(beer))  =  meal(X,Y): unifica con X = food(bread), Y = drink(beer)
meal(food(bread),X)  =  meal(X,drink(beer)) = no unifica, X no puede tener dos valores distintos.


Exercise  2.2 We are working with the following knowledge base:
house_elf(dobby).
witch(hermione).
witch('McGonagall').
witch(rita_skeeter).
magic(X):- house_elf(X).
magic(X):- wizard(X).
magic(X):- witch(X).

?-  magic(house_elf).: false. house_elf(house_elf) no existe como hecho. 
?-  wizard(harry).: false. wizard. no existe como hecho. 
?-  magic(wizard).: false. wizard no existe como hecho. 
?-  magic('McGonagall').: true. Hace match con la tercera regla de magic(X)
?-  magic(Hermione).: intenta con las dos primeras de magic(X) y falla, llega al HEAD de magic(X) con BODY witch(X) y se satisface con el hecho número dos. 