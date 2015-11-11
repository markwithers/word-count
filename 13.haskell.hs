import Data.List
import Data.Char

type Rank = Int
type WordCount = (String, Int)
type RankedWordCount = (Rank, WordCount)

toLowerCase :: String -> String
toLowerCase = map toLower

header :: [String]
header = ["The top 10 most frequently used:", "--------------------------------"]

addHeader :: [String] -> [String]
addHeader body = header ++ body

showDetails :: RankedWordCount -> String
showDetails (rank, (word, count)) = show rank ++ ". " ++ word ++ ": " ++ show count

getWordCount :: [String] -> WordCount
getWordCount xs = (head xs, length xs)

tally :: [String] -> [WordCount]
tally = map getWordCount . group . sort

countDesc :: WordCount -> WordCount -> Ordering
countDesc (_, count1) (_, count2) = compare count2 count1

rankWords :: [WordCount] -> [RankedWordCount]
rankWords = zip [1..]

render :: [RankedWordCount] -> IO ()
render = putStrLn . unlines . addHeader . map showDetails

program :: String -> [RankedWordCount]
program = rankWords . take 10 . sortBy countDesc . tally . map toLowerCase . words

main :: IO ()
main = readFile "words.txt" >>= render . program
