module Input (getValue, getConfirm) where

import Layout

-- Capture value entered by user
getValue :: IO String
getValue = do { value <- getLine;
                if value == ""
                  then getValue
                  else return value
              }

getConfirm func = do { confirm <- getValue;
                        if confirm /= "S" && confirm /= "s"
                          then do {
                            putStr $ msgDanger "Ação não confirmada!";
                            func;
                          }
                          else putStr ""
                      }