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
  putStr "Quantidade para adicionar ao estoque: ";
  quantity <- getValue;
  if quantity == ":q"
    then msgComeBack
    else if quantity == ":l"
      then do {
        listProducts;
        addProduct;
      }
      else do {
        putStr $ "Confirmar entrada do produto no estoque? " ++ textRed ("[s/n] ");
        getConfirm addProduct;
        putStrLn(show(x ++ [quantity]));
        putStr $ msgSuccess "Produto adicionado com sucesso"
      }
}

{-
Get product code
Call getQuantityAddProduct
Pass value in an array
-}
getCodeAddProduct = do {
  putStr "Insira o código do produto: ";
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
  putStrLn $ msgPrimary "Adicionar produtos ao estoque\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
  getCodeAddProduct;
}