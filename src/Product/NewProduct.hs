module Product.NewProduct (newProduct) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

import CustomColors
import Layout
import Input
import Product.ListProducts

confirmNewProduct theNewProduct = do {
  putStr borderLayout;
  putStrLn (
            "Produto: " ++ theNewProduct!!0 ++
            "\nCódigo: " ++ theNewProduct!!1 ++
            "\nPreço: " ++ theNewProduct!!2 ++
            "\nImposto: " ++ theNewProduct!!3 ++ "%"
            );
  putStr $ "Confirmar entrada do produto? " ++ textRed ("[s/n] ");
  getConfirm newProduct;
  putStr $ msgSuccess "Novo produto adicionado com sucesso"
}

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getTaxNewProduct x = do {
  putStr "Imposto do produto: ";
  tax <- getValue;
  if tax == ":q"
    then msgComeBack
    else if tax == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else confirmNewProduct (x ++ [tax])
}

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getPriceNewProduct x = do {
  putStr "Preço do produto: ";
  price <- getValue;
  if price == ":q"
    then msgComeBack
    else if price == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getTaxNewProduct (x ++ [price])
}

{-
Get product code
Call getPriceNewProduct
Pass value in an array
-}
getCodeNewProduct x = do {
  putStr "Código do produto: ";
  code <- getValue;
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getPriceNewProduct (x ++ [code])
}

{-
Get product description
Call getCodeNewProduct
Pass value in an array
-}
getDescriptionNewProduct = do {
  putStr "Descrição do produto: ";
  description <- getValue;
  if description == ":q"
    then msgComeBack
    else if description == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getCodeNewProduct [description]
}

newProduct :: IO ()
newProduct = do { hSetBuffering stdout NoBuffering;
                  putStr $ msgPrimary "Adicionar um novo produto\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
                  getDescriptionNewProduct;
                }