%aplanar(+Xs, -Ys)%
%[a, [b, [c, d], e]] = [a, b, c, d, e]%

aplanar([], []).
aplanar([X | XS], [X | YS]) :- not(is_list(X)), aplanar(XS, YS). 
aplanar([X | XS], YS) :- is_list(X), aplanar(X, ZS), aplanar(XS, XSR), append(ZS, XSR, YS).