module Input (getValue, getConfirm, getConfirmNo, getConfirmYes, getConfirmYesNo) where

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

getConfirmYesNo func1 func2 = do { confirm <- getValue;
                                  if confirm == "S" || confirm == "s"
                                    then func1
                                    else func2
                                }