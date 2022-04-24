import Data.List (sortBy,intercalate)
import Data.Ord (comparing)
import Data.Maybe (listToMaybe)
import Data.Set qualified as S

newtype Rule = Rule (String,String)
instance Show Rule where
    show (Rule (a,b)) = a <> " -> " <> b
type Index = Int

data Result a = Word a
              | Substitution Rule Index a
              | Cyclic a
                deriving (Functor)

instance Show (Result String) where
    show (Word a) = a
    show (Substitution r i a) = "(" <> show r <> ", " <> show i <> ") -> " <> a
    show (Cyclic a) = "Cycle: " <> a

applyRule :: Rule -> String -> [Result String]
applyRule r@(Rule (from,to)) xs = go xs 1 where
    go :: String -> Index -> [Result String]
    go [] i = []
    go xs i | from == take (length from) xs =
        let xs' = to <> drop (length from) xs
            rest = (\s -> ((head xs): ) <$> s) <$> go (tail xs) (i + 1)
        in Substitution r i xs' : rest
    go (x:xs) i = map (\s -> (x:) <$> s) (go xs (i + 1))

applyRules :: [Rule] -> String -> [Result String]
applyRules rs xs = do
    r <- rs
    applyRule r xs

iterateRules :: Int -> [Rule] -> String -> [[Result String]]
iterateRules 0 _ xs = [[]]
iterateRules limit rs xs = go limit xs S.empty where
    go 0 xs _ = [[]]
    go limit xs visited = do
        results <- applyRules rs xs
        let Substitution _ _ xs' = results
        if xs' `S.member` visited
            then return [results, Cyclic xs']
            else 
                let visited' = xs `S.insert` visited
                in case go (limit - 1) xs' visited' of
                    [] -> [[results]]
                    rest -> (results: ) <$> rest

rules = [Rule ("ba", "ab"), Rule ("cb", "bc"), Rule ("ca", "ac")]

findLongestSubstitution limit start = 
    let result = ((Word start) :) <$> iterateRules limit rules start
    in if limit < 0
        then listToMaybe $ reverse $ sortBy (comparing length) result
        else listToMaybe $ dropWhile ((<limit) . length) result

main = do
    putStrLn $ unlines
        [ "Finde möglichst lange Ableitungen mit dem Wortersetzungssystem"
        , intercalate ", " $ show <$> rules
        ]
    let limit = -1
    case findLongestSubstitution limit "ccbbaa" of
        Just r -> mapM_ (\(i,r) -> putStrLn $ show i <> ". " <> show r) (zip [0..] r)
        Nothing -> print "No substitution"
    putStrLn $ replicate 60 '-'
    let limit = 28
    case findLongestSubstitution limit "cbacbcacbcba" of
        Just r -> mapM_ (\(i,r) -> putStrLn $ show i <> ". " <> show r) (zip [0..] r)
        Nothing -> print "No substitution"

