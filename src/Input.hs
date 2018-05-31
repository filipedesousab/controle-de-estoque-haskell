module Input (
    getValue,
    getConfirm,
    getConfirmNo,
    getConfirmYes,
    getConfirmYesNo,
  ) where

import Layout

-- Capture value entered by user
getValue :: IO String
getValue = do
  value <- getLine
  if value == ""
    then getValue
    else return value

-- Function to get user confirmation and return a Boolean
getConfirm :: IO Bool
getConfirm = do
  confirm <- getValue
  return (confirm == "S" || confirm == "s")

{-
Receives a callback function
Get user Confirmation
Execute func if user does not confirm
-}
getConfirmNo :: IO () -> IO ()
getConfirmNo func = do
  confirm <- getValue
  if confirm /= "S" && confirm /= "s"
    then do {
      putStr $ msgDanger "Ação não confirmada!";
      func;
    }
    else putStr ""

{-
Receives a callback function
Get user Confirmation
Execute func if the user confirms
-}
getConfirmYes :: IO () -> IO ()
getConfirmYes func = do
  confirm <- getValue
  if confirm == "S" || confirm == "s"
    then func
    else putStr ""

{-
Receives two callback functions
Get user Confirmation
Execute func1 if the user confirms
Execute func2 if user does not confirm
-}
getConfirmYesNo :: IO () -> IO () -> IO ()
getConfirmYesNo func1 func2 = do
  confirm <- getValue
  if confirm == "S" || confirm == "s"
    then func1
    else func2