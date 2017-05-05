module CFG where
import Debug.Trace
data CFG s = CFG { variables :: [s]
                 , terminals :: [s]
                 , rules :: [(s,[s])]
                 , start :: s }



deriveRuleFunction :: (Eq s) => CFG s -> s -> [[s]]
deriveRuleFunction cfg input
    = let getFunction (a,bs) = (\x -> if x == a then bs else [] )
      in filter (not. null) $ zipWith ($) (map getFunction $ rules cfg ) (repeat input)


genLanguage :: (Eq s, Show s) => CFG s -> [[s]]
genLanguage cfg = genLanguageRec cfg [[start cfg]]
    where genLanguageRec :: (Eq s, Show s) =>CFG s -> [[s]] -> [[s]]
          --genLanguageRec cfg xs | trace ("genLanguageRec " ++ show xs ) False = undefined
          
          genLanguageRec cfg ss 
            = let output = filter (all (flip elem $ terminals cfg)) ss 
                  eligible = filter (any (flip elem $ variables cfg)) ss
                  next = eligible >>= rewriteString cfg
                  --debug = trace ("got output = " ++ show output ++ " eligible = " ++ show eligible ++ " next = " ++ show next) next
              in output ++ genLanguageRec cfg next 

          rewriteString :: (Eq s, Show s) => CFG s -> [s] -> [[s]]
          --rewriteString cfg xs | trace ("rewriteString " ++ show xs ) False = undefined
          rewriteString cfg [x] = let shouldDerive = deriveRuleFunction cfg x 
                                  in if null shouldDerive then [[x]] else shouldDerive
          rewriteString cfg (x:xs) = case deriveRuleFunction cfg x of
                                        [] -> map (x:) $ rewriteString cfg xs
                                        xss -> (++) <$> xss <*> rewriteString cfg xs

c = CFG "0" "12" [('0',"01"), ('0', "1")] '0'

