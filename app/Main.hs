module Main where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Menus
import Product

main :: IO ()
main = do {
            mainMenu;
            op <- getChar;
            case op of
              '2' -> do {
                          addProduct;
                          main;
                        }
              '3' -> do {
                          newProduct;
                          main;
                        }
              _ -> do main
          }
