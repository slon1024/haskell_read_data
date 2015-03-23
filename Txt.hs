import Data.List.Split (splitOn)

main :: IO ()
main = do
  input <- readFile "data/input.txt"
  print $ filter allowQQQ $ lines input

allowQQQ :: String -> Bool
allowQQQ line = (getDomain line) == "qqq.com"
    where getDomain = last . splitOn "@" . last . splitOn " "
