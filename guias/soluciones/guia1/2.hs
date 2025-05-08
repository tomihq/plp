curryOwn :: ((a, b) -> c) -> a -> b -> c
curryOwn f a b = f(a, b)

uncurryOwn :: (a -> b -> c) -> (a, b) -> c
uncurryOwn f(a, b) = f a b