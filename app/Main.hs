module Main where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import System.Exit
import Menus
import Product.AddProduct
import Product.NewProduct

main :: IO ()
main = do {
            mainMenu;
            op <- getLine;
            case op of
              "1" -> do {
                          addProduct;
                          main;
                        }
              "4" -> do {
                          newProduct;
                          main;
                        }
              ":q" -> die "Até logo!"
              _ -> main
          }
