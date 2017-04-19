module Main where

import IO
import System

ting data </span>
fit :: Int -&gt; String -&gt; IO()
fit n infname = bracket (openFile infname ReadMode)
                        hClose
                        (\h -&gt; do hSetBuffering h LineBuffering
                                  ls_sum &lt;- read_dat h (take (2+3*n) [0.0,0.0..])
                                  print $ map last $ sweep $ make_emat n ls_sum)
      </span>
 where read_dat h ls = do term &lt;- hIsEOF h
                          if term
                              then return ls
                              else do line &lt;- hGetLine h
                                      read_dat h (
                                                   if (head line) == '#' || line ==[]
                                                       then ls
                                                       else zipWith (+) ls (make_xy line))
ake_xy str = take (2*n+1) lx ++ (map (*y) $ take (n+1) lx)
        where
            xy = map read $ words str
            x  = xy !! 0
            y  = xy !! 1
            lx = 1.0 : map (*x) lx   

 matrix</span>
make_emat :: Int -&gt; [Double] -&gt; [[Double]]
make_emat n dl = map make_line [0,1..n]
 where
     make_line i = (take (n+1) (drop i dl)) ++ [dl !! (i + 2*n + 1)]

/span>
sweep :: [[Double]] -&gt; [[Double]]
sweep mat = sweep' (length mat) 0 mat

sweep' :: Int -&gt; Int -&gt; [[Double]] -&gt; [[Double]]
sweep' n i mat | i==n = mat
               | otherwise = sweep' n (i+1) mat_next
 where a_i    = mat !! i
       a_ii   = a_i !! i
       v_c    = (take i [0.0,0.0..]) ++ (1.0 : map (/ a_ii)  (drop (i+1) a_i))
       mat_next = zipWith sweep_line [0,1..(n-1)] mat
       sweep_line  j ls | i==j      = v_c
                        | otherwise = take i ls ++
                                      (0.0 : (zipWith (\ x y -&gt;  x - a_ki * y) 
                                              (drop (i+1) ls) (drop (i+1) v_c)))
                                         where a_ki = ls !! i
                                          
main :: IO ()
main = do args  &lt;- getArgs
          fit (read $ head args) (args !! 1)
