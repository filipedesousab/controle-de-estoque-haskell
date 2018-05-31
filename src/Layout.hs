module Layout (
    borderLayout,
    msgDefault,
    msgDanger,
    msgPrimary,
    msgSuccess,
    msgWarning,
    msgComeBack,
    blink,
  ) where

import CustomColors

borderLayout :: String
borderLayout = "\n──────────────────────────────\n"

-- Creates a layout for messages by applying color
msgDefault, msgDanger, msgPrimary, msgSuccess, msgWarning :: String -> String

msgDefault msg = colorDefault ++ borderLayout ++ msg ++ borderLayout
msgDanger msg = colorText "red" "" (borderLayout ++ msg ++ borderLayout)
msgPrimary msg = colorText "cyan" "" (borderLayout ++ msg ++ borderLayout)
msgSuccess msg = colorText "green" "" (borderLayout ++ msg ++ borderLayout)
msgWarning msg = colorText "yellow" "" (borderLayout ++ msg ++ borderLayout)

-- Message displayed using :q
msgComeBack :: IO ()
msgComeBack = do
  putStrLn borderLayout
  putStrLn "Voltando ao menu principal"

-- Keep String flashing
blink :: String -> String
blink msg = "\x1b[5m" ++ msg ++ colorDefault