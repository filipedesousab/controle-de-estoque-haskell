module Main where

import Menus

main :: IO ()
main = do { mainMenu;
            op <- getChar;
            putStrLn ("op: " ++ show(op));
          }
