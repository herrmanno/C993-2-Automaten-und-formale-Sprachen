import Prelude hiding (words)
import Data.List (nub, sort, unfoldr)
import Data.Maybe (isJust, isNothing)

-- | Generate words of length `l`
words 0 = [""]
words l = do
    x <- alphabet
    map (x:) (words (l - 1))
    where alphabet = "ab"

-- | Apply a given rule to a word (at first possible position)
applyRule _ [] = Nothing
applyRule (from,to) xs | take (length from) xs == from = Just (to <> drop (length from) xs)
applyRule rule (x:xs) = (x:) <$> applyRule rule xs

applyRuleN r 0 xs = return xs
applyRuleN r n xs = do
    xs' <- applyRule r xs
    applyRuleN r (n - 1) xs'

rule = ("ab", "ba")

main = do
    print . filter (isNothing . applyRule rule) $  words 7
    let result = nub . sort . filter (isJust . applyRuleN rule 12) $  words 7
    print result 
    let unfoldRule "" = Nothing
        unfoldRule xs = case applyRule rule xs of
            Just xs' -> Just (xs, xs')
            Nothing -> Just (xs, "")
    print . unfoldr unfoldRule $ head result
