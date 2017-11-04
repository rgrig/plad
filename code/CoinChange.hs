module Main where

import Data.Array

main :: IO ()
main = interact (shownl . solve . map read . words)

shownl :: Integer -> String
shownl x = show x ++ "\n"

solve :: [Integer] -> Integer
solve (n:xs) = maybe (-1) id (solveM n xs)

solveM :: Integer -> [Integer] -> Maybe Integer
solveM n xs = dp bounds f (n, m) where
  m = length xs
  bounds = ((1,1), (n,m))
  ds = listArray (1,m) xs
  f f' (i, j) = mmin (g f' (i,j-1)) (fmap (1+) (g f' (i-(ds!j), j)))
  g f' (i, j)
    | i == 0 = Just 0
    | i < 0 = Nothing
    | j == 0 = Nothing
    | otherwise = f' (i, j)

mmin :: Ord a => Maybe a -> Maybe a -> Maybe a
mmin Nothing b = b
mmin a Nothing = a
mmin (Just a) (Just b) = Just (min a b)

tabulate :: (Ix a) => (a,a) -> (a -> b) -> Array a b
tabulate bounds f = array bounds [(i,f i) | i <- range bounds]

dp :: (Ix a) => (a,a) -> ((a->b) -> a -> b) -> a -> b
dp bounds f = (memo!) where
  memo = tabulate bounds (f (memo!))
