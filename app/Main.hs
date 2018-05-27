module Main where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import System.Exit
import Menus
import Product.AddProduct
import Product.NewProduct
import Product.ListProducts
import Product.ProductOutput

main :: IO ()
main = do {
            mainMenu;
            op <- getLine;
            case op of
              "1" -> do {
                          addProduct;
                          main;
                        }
              "2" -> do {
                          productOutput [];
                          main;
                        }
              "3" -> do {
                          listProducts;
                          main;
                        }
              "4" -> do {
                          newProduct;
                          main;
                        }
              ":q" -> die "Até logo!"
              _ -> main
          }
