-- ghc --make -O2 CountDistinct.hs -o CountDistinct-Haskell
-- TODO: fix -- this is pretty ugly
-- TODO: point out Data.HyperLogLog
module Main where

import Data.List
import Data.List.Split
import System.Random as R

main :: IO ()
main = interact (shownl . solve . map read . lines)

shownl :: Double -> String
shownl x = show x ++ "\n"

solve :: [Integer] -> Double
solve xs = combine (foldl oneIP zerorho xs)

zerorho :: [(Integer, Integer)]
zerorho = start ([], R.mkStdGen 123) 100

start (xs, _) 0 = xs
start (xs, g) n = start ((x, 0) : xs, ng) (n - 1)
  where (x, ng) = R.random g :: (Integer, R.StdGen)

oneIP :: [(Integer, Integer)] -> Integer -> [(Integer, Integer)]
oneIP ars x = map (oneHASHoneIP x) ars

oneHASHoneIP :: Integer -> (Integer, Integer) -> (Integer, Integer)
oneHASHoneIP x (a, r) = (a, max r (rho (a + x)))

combine :: [(Integer, Integer)] -> Double
combine = median . map avg . chunksOf 3 . map (2^) . map snd

avg :: [Integer] -> Double
avg xs = fromIntegral (foldl (+) 0 xs) / fromIntegral (length xs)
median xs = sort xs !! (length xs `div` 2)

rho :: Integer -> Integer
rho 0 = 32
rho x
  | x `mod` 2 == 1 = 0
  | otherwise = 1 + rho (x `div` 2)
