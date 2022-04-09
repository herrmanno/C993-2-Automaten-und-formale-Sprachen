import Data.List (sortBy)
import Data.Ord (comparing)
import Data.Maybe (listToMaybe)
import Data.Set qualified as S

type Rule = (String,String)
type Index = Int

data Result a = Word a
              | Substitution Rule Index a
              | Cyclic a
                deriving (Functor)

instance Show a => Show (Result a) where
    show (Word a) = show a
    show (Substitution r i a) = show r <> ", " <> show i <> " -> " <> show a
    show (Cyclic a) = "Cycle: " <> show a

applyRule :: Rule -> String -> [Result String]
applyRule r@(from,to) xs = go xs 1 where
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

rules = [("ba", "ab"), ("cb", "bc"), ("ca", "ac")]

findLongestSubstitution limit start = 
    let result = ((Word start) :) <$> iterateRules limit rules start
    in listToMaybe $ reverse $ sortBy (comparing length) result

main = do
    let limit = -1
    case findLongestSubstitution limit "ccbbaa" of
        Just r -> mapM_ print r
        Nothing -> print "No substitution"
    print "-------------------"
    let limit = 6
    case findLongestSubstitution limit "cbacbcacbcba" of
        Just r -> mapM_ print r
        Nothing -> print "No substitution"

