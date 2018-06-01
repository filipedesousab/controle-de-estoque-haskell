module Menus ( mainMenu ) where

import Layout
import CustomColors

mainMenu :: IO ()
mainMenu = do
  putStrLn $ msgPrimary "Escolha uma opção"
  putStrLn $ colorCyan ++ "Digite:"
  putStrLn "1- Entrada de produtos"
  putStrLn "2- Saída de produtos"
  putStrLn "3- Estoque"
  putStrLn "4- Buscar produto por código"
  putStrLn "5- Cadastro de produtos"
  putStrLn ":q- Sair"
  putStrLn $ borderLayout ++ colorDefault

