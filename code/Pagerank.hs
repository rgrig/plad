module Main where

import Data.List

type Rank = Double

main :: IO ()
main = interact (showRanks . solve . parse)

solve :: [[Int]] -> [Rank]
solve graph = solveLoop graph (replicate n (1 / fromIntegral n))
  where n = length graph

solveLoop :: [[Int]] -> [Rank] -> [Rank]
solveLoop graph oldRanks =
  if distance < 1e-6
  then newRanks
  else solveLoop graph newRanks
  where
    distance = foldl max 0 $ map abs $ zipWith (-) oldRanks newRanks
    newRanks = clump 0 $ sort $ foldl distribute [] (zip graph oldRanks)
    distribute acc (ys, xrank) = map (\y->(y,credit)) ys ++ acc
      where credit = xrank / fromIntegral (length ys)
    clump i xs = if i == length graph then [] else irank : clump (i+1) ys
      where
        (irank, ys) = get 0 xs
        get acc ((j, r) : ys) | i == j = get (acc + r) ys
        get acc ys = (acc, ys)

-- NOTE: Also adds the dummy node.
parse :: String -> [[Int]]
parse s = [0..n] : gs
  where [n] : gs = map (map read) $ map words $ lines s

showRanks :: [Rank] -> String
showRanks rs = do
  r <- rs
  show r ++ "\n"
--showRanks rs = rs >>= (\r -> show r ++ "\n")
--showRanks rs = concatMap (\r -> show r ++ "\n") rs
--showRanks rs = concat $ map (\r -> show r ++ "\n") rs
