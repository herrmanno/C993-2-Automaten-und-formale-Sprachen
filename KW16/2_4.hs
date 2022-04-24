import Data.List (tails, inits, sortBy)
import Data.Ord (comparing)
import Data.Set qualified as S
import Control.Monad ((<=<))

buildWords = go (S.singleton "b")  where
    go ws = let ws' =
                    [ w
                    | a <- S.toList ws
                    , b <- S.toList ws
                    , let w = 'a' : a ++ b
                    , w `S.notMember` ws
                    , length w < 9
                    ]
            in if null ws' then S.toList ws else go (S.union ws (S.fromList ws'))

findPalindromes :: String -> [String]
findPalindromes = filter isPalindrome . inits <=< tails
    where isPalindrome s = s == reverse s

main = do
   let ws = buildWords
   putStrLn "Alle Worte mit Länge <= 8"
   mapM_ putStrLn ws
   putStrLn $ replicate 60 '-'
   let ps = sortBy (comparing length) . filter (not . null) . S.toList . S.fromList $ findPalindromes =<< ws
   putStrLn "Alle Palindrome"
   mapM_ putStrLn ps
   putStrLn $ replicate 60 '-'
   putStrLn "Wortersetzungssystem S = {b -> abb}, Startwort = b"
