vacio(nil).
raiz(bin(_, R, _), R).

altura(nil, 0).
altura(bin(I, R, D), A) :- altura(I, AI), altura(D, AD), ALT is max(AI, AD), A is 1+ALT.

cantNodos(nil, 0).
cantNodos(bin(I, R, D), N) :- cantNodos(I, NI), cantNodos(D, ND), N is 1+NI+ND.