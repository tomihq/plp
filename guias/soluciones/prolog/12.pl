/* inorder: izq + raiz + der. inorder(+AB, -Lista) */ 
inorder(nil, []). 
inorder(ab(AB), Res) :- inorder(AB, Res).
inorder(bin(Izq, R, Der), Res) :- inorder(Izq, Res2), inorder(Der, Res3), append(Res2, [R | Res3], Res).  

/* abb(+T) es verdadero si y solo si todos los nodos de la izq son menores que los de la der. */
abb(nil).
abb(ab(AB)) :- abb(AB).
abb(bin(Izq, R, Der)) :- todosMenores(Izq, R), todosMayores(Der, R).

todosMenores(nil, _).
todosMenores(bin(Izq, R, _), Raiz) :- R =< Raiz, todosMenores(Izq, R).

todosMayores(nil, _).
todosMayores(bin(_, R, Der), Raiz) :- Raiz =< R, todosMayores(Der, R).

