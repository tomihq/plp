/* intercalar: 
La idea es que mantengan el orden original.

Ej.: [1, 2], [3, 4]
[1, 2, 3, 4]

[1, 3, 2, 4] L1 L2 L1 L2
[1, 3, 4, 2] L1 L2 L2 L1 

[3, 1, 2, 4] L2 L1 L1 L2 
[3, 1, 4, 2] L2 L1 L2 L1 
[3, 4, 1, 2] L2 L2 L1 L1 
*/
intercalar([], L2, L2). 
intercalar(L1, [], L1).
intercalar([H | T1], L2, [H | Res]) :- intercalar(T1, L2, Res).
intercalar(L1, [E | T2], [E | Res]) :- intercalar(L1, T2, Res).