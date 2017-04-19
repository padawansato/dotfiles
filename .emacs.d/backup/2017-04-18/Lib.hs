module Lib
    ( someFunc
    ) where


someFunc :: IO ()

someFunc = do
  putStrLn "type w value"
    w <- readLn
-- fxyzw = let x = 1
--             y = 2
--             z = 3
--         in  xyzw x y z w = (x * y) + z + w
--    putStrLn fxyzw
  print w
-- xyzw x y z w = (x * y) + z + w 
-- ans = (xyzw x y z w)
-- print ans
