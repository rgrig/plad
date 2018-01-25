main = do
  s <- getContents
  let xs = map read (words s)
  putStrLn (show (xs!!0 + xs!!1))
