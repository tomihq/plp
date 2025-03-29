# Programación Funcional
No busco reemplazar la bibliografía original ni mucho menos, sino que la idea es acá poner conceptos chiquitos que me sirven a mí mentalmente para resolver las cosas.
Entre muchas cosas, la idea acá es anotar tips que hayan dado los profes que me hayan parecido copados.

## Asociación de la aplicación
Por defecto, si no lo explicitamos, Haskell asocia la aplicación hacia la izquierda.

Es decir, si tenemos f g 4, Haskell hace (f g) 4. Lo que daría error de tipado si en realidad queríamos aplicar 4 a g.

Muchas veces para evitar el uso de paréntesis excesivamente, usamos $.

### Símbolo $
Se utiliza para evitar el uso excesivo de paréntesis.

    f (g 4) equivale a f $ g 4

## Asociación de -> 
Por defecto, si no lo explicitamos, Haskell asocia las flechas a la derecha.

Es decir, si tenemos Int -> Int -> Int, el tipo es Int -> (Int -> Int). Esto quiere decir que, recibe un Int y devuelve una función que espera un Int y devuelve como respuesta un Int.

## Composición de funciones
Es exactamente igual que en matemática. Eso quiere decir que (a -> b) -> (c -> a) -> c -> b.

Obligatorio que los paréntesis del tipado vayan de esa forma, porque la composición f . g es meterle un input a g, el resultado de g se lo mete en f, y f te da un resultado.

Ej.: 

    multiplicarPorTres :: Int -> Int 
    multiplicarPorTres x = (*) 3 x

    sumarCinco :: Int -> Int 
    sumarCinco x = (+) 5 x


    (multiplicarPorTres . sumarCinco) 3 => ((3 + 5) * 3) = 24

    Nota: multipicarPorTres . sumarCinco forman otra función, que indirectamente tendría esta forma

    componerDos :: Int -> Int 
    componerDos x = (multiplicarPorTres . sumarCinco) x

## Aplicar una función vs Componer una función
No es lo mismo aunque en algunos casos parezca que sí.

    multiply multiply != multiply . multiply

## Currificación
La currificación de funciones en Haskell sirve para que las funciones sean reutilizables y que las podemos aplicar parcialmente.

Que una función sea aplicable parcialmente significa que si le mandas un argumento, te devuelve **otra función** que ya tiene precargado ese **argumento que mandaste antes** y se queda esperando los demás antes de ejecutarse.

PD: No tiene sentido hablar de currificación cuando una función tiene "un solo parámetro" porque ya sería aplicar la función.

¿Por qué puse "un solo parámetro"? Porque en realidad, en programación funcional, todas las funciones tienen un único parámetro.

Ej.:

    sumarNumeros :: Int -> (Int -> Int)
    sumarNumeros x y = x + y

    Equivale a 

    sumarNumeros :: Int -> (Int -> Int)
    sumarNumeros x y = (+) x y

    Equivale a 

    sumarNumeros :: Int -> (Int -> Int)
    sumarNumeros = (+)

¿Por qué usaría el enfoque número 3, y no el 1 o el 2? Por legibilidad. Pero veamos por qué funciona.

Dijimos recién que las funciones toman un único argumento, eso quiere decir que, en realidad con mandarle uno solo, ya funcionaría.

Ej.: 

    sumarSiempreDos :: Int -> Int 
    sumarSiempreDos x = sumarNumeros 2 x

    Equivale a 
    
    sumarSiempreDos :: Int -> Int 
    sumarSiempreDos = sumarNumeros 2


En este caso, sumarSiempreDos está aplicando parcialmente a sumarNumeros. ¿Por qué? Bueno, porque le estamos mandando **un único parámetro** de los **dos totales que espera**. 

El tipado original de **sumarNumeros :: Int -> Int -> Int** pero ahora, en sumarSiempreDos sumarNumeros termina siendo **Int -> Int** porque le falta un único parámetro para ser ejecutada.

Probá en la consola si querés, definí sumarNumeros y poné **:t sumarNumeros 2**, el tipo resultante va a ser **Int -> Int**.

### Currificando una función no currificada
Currificación: La idea mental es que vos obligues a pasar los argumentos separados, y apliques la función (no currificada) original, de la misma manera (en bloque).

Uncurrificación: La idea mental es que vos obligues a pasar los argumentos en un bloque y apliques la función (currificada) original mandando esos parámetros a la función separados.

Imaginate que un amigo tuyo que no sabe tanto de programación funcional hizo una función que espera una tupla, pero vos querés aplicar esa función de a pasitos.

    //la que hizo tu amigo
    multiplicar :: (Int, Int) -> Int
    multiplicar x y = (*) x y 

    Vos necesitás reutilizar esta lógica pero que le puedas mandar un solo número siempre y multiplicar siempre por dos.

    multiplicarPorDos :: Int -> Int 
    multiplicarPorDos = curry multiplicar 2

    De esta forma, podés usar la función que hizo tu amigo pero sin ejecutarla al toque porque le falta uno de los argumentos. Entonces, hasta que multiplicarPorDos no lo reciba, no va a calcular multiplicar.

La implementación de curry viene por defecto en el preludio de Haskell, como también la de uncurry, pero si las querés acá están.

    curry :: ((a, b) -> c) -> a -> b -> c
    curry f a b = f (a, b)

    uncurry :: a -> b -> c -> ((a, b) -> c)
    uncurry f (a, b) = f a b

## Lambda Functions
Las lambda functions son funciones anónimas que cumplen un propósito dado pero **no se reutilizan**. Si las funciones que estás utilizando como lambda las reutilizás en varios lados, optá por definir una función con nombre.

Hay muchas veces también que hay funciones de uso único que no se nos ocurre un nombre y por eso usamos lambda functions.

## Duplicidades en Lambda Functions

Muchas veces, por legibilidad optamos por eliminar cosas ambiguas. 

Ej. 

    \f -> \g -> \x -> (f.g) x equivale a \f g x -> (f.g) x 

    En este ejemplo se muestra que en vez de hacer 3 lambda diferentes, se puede hacer una única "que reciba todos los argumentos" aunque en realidad siguen siendo 3 lambda diferentes.

## Duplicidades de argumentos en función
Llamamos duplicidades a los argumentos que a nivel borde son el mismo. Esto es duplicado en Haskell.

Ej.: 

    sumarUno :: Int -> Int
    sumarUno x = (+) 1 x

    Como x es el último parámetro de la izquierda, y el de la derecha si lo eliminamos es igual.
    
    Entonces, equivale a

    sumarUno :: Int -> Int 
    sumarUno = (+) 1

    Al aplicar la función, Haskell va a recibir el Int que falta.

    Lo mismo pasa para varios argumentos

    sumarNumeros :: Int -> Int -> Int
    sumarNumeros x y = (+) x y 

    Equivale a 

    sumarNumeros :: Int -> Int -> Int 
    sumarNumeros = (+)

    Cuando vos llames a sumarNumeros 1 2 Haskell lo aplicaría así (+) 1 2

Esto es muy importante de entender, porque muchas veces, para mejor legibilidad eliminamos los argumentos explícitos pero a la hora de demostrar hay que recordar que están ahí, y eso nos lo damos cuenta por el tipado.

## Undefined
Es un valor que puede representar varios tipos. En la lógica le llamamos bottom. Una función que tiene como definición undefined indica que no fue definida para hacer algo. 

## Listas
Solo tienen un solo tipo. 

Se pueden armar a través de comprensión, enumeración o manualmente. 

Si se utilizan listas infinitas, ej. por enumeración es importante saber que no se puede tener más de un generador infinito.

Tienen una cabeza y una cola. Acceder a la cabeza o cola cuando la lista está vacía explota. 

Las representaciones de las listas siempre son a través de operadores recursivos, es decir, cuando vemos una listita en realidad se arma de una forma particular y de esa forma la interpreta Haskell.

Ese operador se llama *cons* y se representa con **(i)** donde su tipo es el siguiente: ** a -> [a] -> [a] **. 

Gracias a la currificación, notamos que es aplicable parcialmente de tal manera que podemos definir que pueda agregar un elemento fijo a cualquier lista dada. 

Ej.: Como la "->" asocia a la derecha, por defecto Haskell lo interpreta de esta manera a -> ([a] ->[a]). Esto significa que si le mandamos un elemento, nos devuelve la función (:) elem que ahora solamente espera la lista.

¿Aplicación? Veamos todas las formas posibles :) 

Con lambda functions:

    agregarDosALista :: [a] -> [a]

    agregarDosALista = (\l -> (:) 2 l)



Con lambda functions removiendo argumento punto a punta:

    agregarDosALista :: [a] -> [a] 

    agregarDosALista = (:) 2


Con aplicación prefija (sin lambda): 

    agregarDosALista :: [a] -> [a]

    agregarDosALista l = (:) 2



Con aplicación infija (sin lambda):

    agregarDosALista :: [a] -> [a]

    agregarDosALista l = 2:l









