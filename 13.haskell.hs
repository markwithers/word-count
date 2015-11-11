import Data.List

header :: [[Char]]
header = ["The top 10 most frequently used:", "--------------------------------"]

addHeader :: [a] -> [a] -> [a]
addHeader header body = header ++ body

showDetails :: Show a => (a, ([Char], a)) -> [Char]
showDetails (idx, (word, count)) = (show idx) ++ ". " ++ word ++ ": " ++ (show count)

makeTally :: [a] -> (a, Int)
makeTally xs = (head xs, length xs)

tallyWords :: (Ord a, Eq a) => [a] -> [(a, Int)]
tallyWords = map makeTally . group . sort

sortTallyDesc :: Ord a => (b, a) -> (b, a) -> Ordering
sortTallyDesc a b = compare (snd b) (snd a)

addRanking :: [a] -> [(Int, a)]
addRanking = zip [1..]

render :: [(Int, ([Char], Int))] -> IO ()
render = putStrLn . unlines . (addHeader header) . map showDetails

getTop10 :: String -> [(Int, (String, Int))]
getTop10 = addRanking . (take 10) . (sortBy sortTallyDesc) . tallyWords . words

main :: IO ()
main = do
  content <- readFile "words.txt"
  render $ getTop10 content
