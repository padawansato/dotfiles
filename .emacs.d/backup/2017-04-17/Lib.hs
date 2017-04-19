module Lib
    ( someFunc
    ) where

someFunc :: IO ()
x = 1
y = 2
z = 3
xyzw = (x * y) + z + w 
someFunc = do
  -- putStrLn "type w value"
  -- w <- getLine
  -- putStrLn w
  putStrLn xyzw

{-成功
a = 1
b = 2
c = a + b
someFunc = do
  print c
-}

{-ここまでは成功
-- someFunc :: IO ()
-- someFunc = do
--   putStrLn "type w value"
--   w <- getLine
--   putStrLn w
-}
  
-- xyzw x y z w =  (x * y) + z + w 
-- someFunc = print (xyzw 1 2 3 )  -- 出力: 5

-- someFunc = do
--     let a = 1
--         b = 2
--         c = a + b
--     putStrLn c

-- someFunc = do 
--   putStrLn "type the value of w"
--     w <- getLine
--     let -- x = 1
--         -- y = 2
--         -- z = 3
--         xyzw x y z w =  (x * y) + z + w 
--         putStrLn xyzw
