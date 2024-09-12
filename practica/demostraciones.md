# Demostraciones
## Principio de Extensionalidad Funcional 
Probar <b> curry . uncurry = id </b> <br/>
En este tipo de ejercicios es recomendable tener a mano las definiciones de cada una de las funciones porque vamos a tener que probarlas punto a punto. 
<ul>
    <li> curry f = (\x y -> f(x,y))</li>
    <li> uncurry f (\(x, y) -> f x y)</li>
    <li> id x = x </li>
    <li> (f.g) x = f (gx)</li>
</ul>
Como tenemos que probar una igualdad entre funciones, vamos a tener que probar que son iguales punto a punto. Esto podemos hacerlo a través del <b> principio de extensionalidad de funciones. </b>

Recordemos que el principio de extensionalidad de funciones dice lo siguiente 

$$
f, g \ :: \ a \rightarrow b
$$

$$
f = g \iff (\forall x \ :: \ a) \ (f(x) = g(x))
$$

Entonces queremos ver que 
$$ 
(\forall f :: a \rightarrow b \rightarrow c) (curry . uncurry f = id f)
$$