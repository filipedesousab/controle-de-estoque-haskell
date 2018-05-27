module Input (getValue, getConfirm, getConfirmNo, getConfirmYes) where

import Layout

-- Capture value entered by user
getValue :: IO String
getValue = do { value <- getLine;
                if value == ""
                  then getValue
                  else return value
              }

getConfirm :: IO Bool
getConfirm = do { confirm <- getValue;
                  return (confirm == "S" || confirm == "s");
                }

getConfirmNo func = do { confirm <- getValue;
                        if confirm /= "S" && confirm /= "s"
                          then do {
                            putStr $ msgDanger "Ação não confirmada!";
                            func;
                          }
                          else putStr ""
                      }

getConfirmYes func = do { confirm <- getValue;
                        if confirm == "S" || confirm == "s"
                          then func
                          else putStr ""
                      }