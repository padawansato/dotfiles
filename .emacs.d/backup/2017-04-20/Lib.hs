module Lib
    ( someFunc
    ) where


someFunc :: IO ()

someFunc = do cs <- getContesnts
               putStr cs
