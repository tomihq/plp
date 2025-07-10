%subsecuenciaEstrictamenteCreciente(+L, -S): Donde S es cada subsecuencia posible de L estrictamente creciente. Los valores deben respetar el orden de aparición.
%Varios requiere: 
    %Los elementos respetan el orden de aparición -> lo tomo, o no lo tomo. 
    %S es una subsecuencia de L. Es decir, lo armo en base a L. 
    %S es estrictamente creciente. Es decir, si tengo la lista vacia es creciente, la lista con un elemento es creciente, caso contrario comparo los dos elementos consecutivos.

%subsecuencia(+L, -S)
subsecuencia([], []).
subsecuencia([X | XS], [X | S]) :- subsecuencia(XS, S).
subsecuencia([_ | XS], S) :- subsecuencia(XS, S). 

%estrictamenteCreciente(+L)
estrictamenteCreciente([]).
estrictamenteCreciente([_]).
estrictamenteCreciente([X, Y | XS]) :- X < Y, estrictamenteCreciente([Y | XS]).

%subsecuenciaEstrictamenteCreciente(+L, -S)
subsecuenciaEstrictamenteCreciente(L, S) :- subsecuencia(L, S), estrictamenteCreciente(S).

%subsecuenciaCrecienteMasLarga(+L, -S): Devuelve una subsecuencia de mayor longitud. Puede haber más de un resultado.
%Requiere: Existe una subsecuencia, y no existe otra con mayor longitud que la que encontré. Nótese que acá el criterio de "NO EXISTE", es otra con LONGITUD mayor. No me importa si hay otra subsecuencia que tiene IGUAL longitud que la que encontré.

subsecuenciaCrecienteMasLarga(L, S) :- subsecuenciaEstrictamenteCreciente(L, S), length(S, L1), not((subsecuenciaEstrictamenteCreciente(L, S2), length(S2, L2), L2 > L1)).