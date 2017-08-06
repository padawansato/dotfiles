-- 1
f1 a _ _ _ = a
f2 _ b _ _ = b
f3 _ _ c _ = c
f4 _ _ _ d = d

-- 2
f1l = \a b c d -> a
f2l = \a b c d -> b
f3l = \a b c d -> c
f4l = \a b c d -> d

-- 3
f3_3 a b c d = f2 _ c _ _
f4_3 a b c d = f3_3 _ _ d _

-- 4
f1_4 a b c d = f4_3 _ _ _ a
f2_4 a b c d = f4_3 _ _ _ b
f3_4 a b c d = f4_3 _ _ _ c

-- 5
{-
ghciで読み込んで型を確認する
-}
