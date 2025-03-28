vecino(X, Y, [X | [Y | _]]).
vecino(X, Y, [_ | Ls]) :- vecino(X,Y, Ls).

/*
i) Espero y = 6, y = 3.

?- vecino(5, Y, [5,6,5,3]).
├─ ?- vecino(5, 6, [5|[6|[5,3]]]).          {X := 5, Y := 6, Ls := [5,3]}
│  └─ true.                                 {Y := 6}
└─ ?- vecino(5, Y, [6,5,3]).                {X := 5, W := 5, Ls := [6,5,3]}
   └─ ?- vecino(5, Y, [5,3]).               {X := 5, W := 6, Ls := [5,3]}
      ├─ ?- vecino(5, 3, [5|[3|[]]]).       {X := 5, Y := 3, Ls := []}
      │  └─ true.                           {Y := 3}
      └─ ?- vecino(5, Y, [3]).              {X := 5, W := 5, Ls := [3]}
         └─ ?- vecino(5, Y, []).            {X := 5, W := 3, Ls := []}
            └─ false.
            

ii) Espero y = 3, y = 6
vecino(X, Y, [_ | Ls]) :- vecino(X,Y, Ls).
vecino(X, Y, [X | [Y | _]]).

El resultado acá se invierte porque se ejecuta siempre la primera regla hasta que la lista es vacía. Y luego resuelve de derecha a izquierda, por lo tanto el primer caso que termina matcheando con la segunda ecuacion es con y = 3, y luego casi volviendo totalmente al principio nos queda y = 6.

*/
