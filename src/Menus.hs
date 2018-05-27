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
          putStrLn "1- Entrada de produtos"
          putStrLn "2- Saída de produtos"
          putStrLn "3- Estoque"
          putStrLn "4- Cadastro de produtos"
          putStrLn ":q- Sair"
          putStrLn borderMenu

