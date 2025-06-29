%corteMasParejo(+L, -L1, -L2) que dada una lista de numeros, realiza el corte más parejo posible con respecto a la suma de sus elementos. 
% Busco dos listas L1 y L2 que concatenadas dan L. 
% Busco dos listas más L3 y L4 y digo que L1 y L2 cumplen que la diferencia entre la sumas de los elementos de ambas listas es menor a que L3 y L4.

corteMasParejo(L, L1, L2) :- append(L1, L2, L), not(hayUnCorteMasParejo(L1, L2, L)).

hayUnCorteMasParejo(I, D, L) :- append(I2, D2, L), esMasParejo(I2, D2, I, D).

esMasParejo(I2, D2, I, D) :- sum_list(I2, SI2), sum_list(D2, SD2),
                             sum_list(I, SI), sum_list(D, SD),
                             abs(SI - SD) > abs(SI2 - SD2).