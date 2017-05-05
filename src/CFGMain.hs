import CFGIO
import System.Environment
import System.IO

main = do 
    args <- getArgs
    performAccordingToArguments args


defaultNum = 100


performAccordingToArguments :: [String] -> IO ()
performAccordingToArguments [] = do 
                contents <- hGetContents stdin
                putStrLn $ processInput contents defaultNum
performAccordingToArguments (fileName:xs) = do 
                handle <- openFile fileName ReadMode
                contents <- hGetContents handle
                let n = case xs of 
                            [] -> defaultNum
                            (x:_) -> read x
                putStrLn $ processInput contents n


processInput :: String  -- grammar file content
                -> Int  -- number of strings to display
                -> String -- the output
processInput str n = let lang = genLanguageFromFile str
                      in unlines $ take n lang


