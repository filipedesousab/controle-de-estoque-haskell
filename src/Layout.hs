module Layout
  (
    borderLayout,
    msgDefault,
    msgDanger,
    msgPrimary,
    msgSuccess,
    msgComeBack,
  ) where

import CustomColors

borderLayout = "\n******************************\n"
msgDefault msg = colorDefault ++ borderLayout ++ msg ++ borderLayout
msgDanger msg = colorText "red" "" (borderLayout ++ msg ++ borderLayout)
msgPrimary msg = colorText "cyan" "" (borderLayout ++ msg ++ borderLayout)
msgSuccess msg = colorText "green" "" (borderLayout ++ msg ++ borderLayout)

-- Message displayed using :q
msgComeBack = do {
  putStrLn borderLayout;
  putStrLn "Voltando ao menu principal";
}