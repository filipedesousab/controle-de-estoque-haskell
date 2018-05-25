module Menus
    ( mainMenu
    ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

borderMenu = "******************************"
msgMenu = borderMenu ++ "\nEscolha uma opção\n" ++ borderMenu

mainMenu :: IO ()
mainMenu = do
          putStrLn msgMenu
          putStrLn "Digite:"
          putStrLn "1- Vender um produto"
          putStrLn "2- Incrementar estoque"
          putStrLn "3- Adicionar um novo produto"
          putStrLn borderMenu

