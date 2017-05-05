module CFGIO where 
import CFG
import Data.List
import Data.List.Split


readCFGFromFile :: String -> CFG String
readCFGFromFile str = let list = map readLine $ lines str
                          symbols' = nub $ map (\(x,_) -> x) list
                          terminals' = filter (\x -> not $ x `elem` symbols' ) $ 
                                    nub $ concat $ map (\(_,xs) -> concat xs) list
                          rules' = concat $ map (\(x,ys) -> map ((,) x) ys) list
                          startSymbol' = head symbols'
                      in CFG symbols' terminals' rules' startSymbol'
                          


readLine :: String -> (String, [[String]])
readLine str = let (lhs:rhs:_) = splitOn "->" str
               in (lhs, interpreteRHS rhs)
               


interpreteRHS :: String -> [[String]]
interpreteRHS str = let parts = splitWhen (=='|') str
                        words = map (splitWhen (==':')) parts
                    in words

genLanguageFromFile :: String -> [String]
genLanguageFromFile str = let cfg = readCFGFromFile str
                              lang = genLanguage cfg
                          in map concat lang
