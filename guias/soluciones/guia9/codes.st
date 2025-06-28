Number >> fact
    |i res|
    i:=1.
    res:=1.
    [i<=self] whileTrue: [res := res * i. i:=i+1].
    ^res.

//Asumo que como me mandan este mensaje desde un closure. Lo unico que tengo que hacer es devolver otro bloque igual pero currificado.
BlockClosure >> curry
^[:x | [:y | self value: x value: y]]

//Hago self veces aBlock. No devuelvo nada. Solo ejecuto el bloque. 
Number >> timesDo: aBlock
    |i|
    i:=1.
    [i<=self] whileTrue: [aBlock value. i:=i+1.]
    ^self. 


# Colecciones
arr := #(1 2 4).
arr add: 1. -> Falla. No se puede agregar un elemento a un símbolo. Son inmutables.

bag := Bag with: 1 with: 2 with: 3.
bag add: 1. //Al ser un multiconjunto se ve algo así: {1: 2, 2: 1, 3: 1} donde el 1 ahora está dos veces.

list := OrderedCollection withAll: #(1 2 3 4).
list add: 0. // Una lista con los elementos [1, 2, 3, 4, 0]
list at: 1 put: 2. //La lista es actualizada y ahora es [2, 2, 3, 4, 0]

sortedCollection := SortedCollection withAll: #(1 2 3 4).
sortedCollection add: 0. //Una lista ordenada ahora con los elementos [0, 1, 2, 3, 4]

set := Set withAll: #(1 2 1).
set add: 3. //Un conjunto con los elementos 1, 2, 3. No importa el orden! 

//¿No funciona con arrays? (no tiene add).
Collection > map: aBlock
    |col|
    col := (self class) new.
    self do: [:e | col add: (aBlock value: e)].
    ^col. 

arr := Array with: 1 with: 2.
arrFiltered := arr select: [ :e | e == 1 ].