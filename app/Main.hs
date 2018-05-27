module Main where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Menus
import Product.AddProduct
import Product.NewProduct

main :: IO ()
main = do {
            mainMenu;
            op <- getChar;
            case op of
              '1' -> do {
                          addProduct;
                          main;
                        }
              '4' -> do {
                          newProduct;
                          main;
                        }
              _ -> do main
          }
