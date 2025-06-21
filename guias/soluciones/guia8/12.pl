inorder(nil, []).
inorder(bin(I, R, D), L) :- inorder(I, L1), inorder(D, L2), append(L1, [R], L3), append(L3, L2, L).