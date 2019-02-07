main = do
  s <- getContents
  let xs = map read (words s)
  putStrLn (show (sum xs))
