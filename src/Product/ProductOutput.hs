module Product.ProductOutput (productOutput) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

import CustomColors
import Layout
import Input
import Product.ListProducts

{-
Get quantity of products
Call putStrLn
Pass value in an array
-}
getQuantityAddProduct :: String -> [[String]] -> IO ()
getQuantityAddProduct y x = do {
  putStr "Digite a quantidade: ";
  quantity <- getValue;
  if quantity == ":q"
    then msgComeBack
    else if quantity == ":l"
      then do {
        listProducts;
        productOutput x;
      }
      else do {
        putStr $ "Deseja incluir mais itens? " ++ textRed ("[s/n] ");
        confirm <- getConfirm;
        if confirm
          then do {
            productOutput (x ++ [y:quantity:[]]);
          }
          else do {
            putStr $ "Concluir pedido? " ++ textRed ("[s/n] ");
            getConfirmYesNo (putStrLn(show(x ++ [y:quantity:[]]))) (productOutput []);
          }
      }
}

{-
Get product code
Call getQuantityAddProduct
Pass value in an array
-}
getCodeAddProduct :: [[String]] -> IO ()
getCodeAddProduct x = do {
  putStr "Digite o código do produto: ";
  code <- getValue;
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do {
        listProducts;
        productOutput x;
      }
      else getQuantityAddProduct code x
}

-- Function for products output
productOutput :: [[String]] -> IO ()
productOutput x = do {
  hSetBuffering stdout NoBuffering;
  putStrLn $ msgPrimary "Saída de produtos\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
  getCodeAddProduct x;
}