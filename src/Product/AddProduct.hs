module Product.AddProduct
    ( addProduct ) where

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
getQuantityAddProduct x = do {
  putStr "Digite a quantidade: ";
  quantity <- getValue;
  if quantity == ":q"
    then msgComeBack
    else if quantity == ":l"
      then do {
        listProducts;
        addProduct;
      }
      else do {
        putStr $ "Confirmar entrada do produto? " ++ textRed ("[s/n] ");
        confirm <- getConfirm;
        if confirm
          then do {
            putStrLn(show(x ++ [quantity]));
            putStr $ msgSuccess "Entrada realizada com sucesso!";
            putStr $ "Deseja realizar mais entrada? " ++ textRed ("[s/n] ");
            getConfirmYes addProduct;
          }
          else addProduct;
      }
}

{-
Get product code
Call getQuantityAddProduct
Pass value in an array
-}
getCodeAddProduct = do {
  putStr "Digite o código do produto: ";
  code <- getValue;
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do {
        listProducts;
        addProduct;
      }
      else getQuantityAddProduct [code]
}

addProduct :: IO ()
addProduct = do {
  hSetBuffering stdout NoBuffering;
  putStrLn $ msgPrimary "Entrada de produtos\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
  getCodeAddProduct;
}