module Product.NewProduct (newProduct) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

import CustomColors
import Layout
import Input
import Product.ListProducts
import Product.Products

-- Function to confirm product registration
confirmNewProduct theNewProduct = do {
  putStr $ "Confirmar cadastro do produto? " ++ textRed ("[s/n] ");
  confirm <- getConfirm;
        if confirm
          then do {
            result <- setNewProduct (read (theNewProduct!!0)::Int, theNewProduct!!1, read (theNewProduct!!2)::Double, read (theNewProduct!!3)::Double);
            if result == "existingProduct"
              then putStr $ msgWarning "Produto já cadastrado!";
              else putStr $ msgSuccess "Cadastro realizado com sucesso!";
            putStrLn $ "Deseja realizar outro cadastro? " ++ textRed ("[s/n] ");
            getConfirmYes newProduct;
          }
          else newProduct;
}

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getTaxNewProduct x = do {
  putStr "Digite o imposto do produto: ";
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
  putStr "Digite o preço do produto: ";
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
Get product description
Call getPriceNewProduct
Pass value in an array
-}
getDescriptionNewProduct x = do {
  putStr "Digite a descrição do produto: ";
  description <- getValue;
  if description == ":q"
    then msgComeBack
    else if description == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getPriceNewProduct (x ++ [description])
}

{-
Get product code
Call getDescriptionNewProduct
Pass value in an array
-}
getCodeNewProduct = do {
  putStr "Digite o código do produto: ";
  code <- getValue;
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getDescriptionNewProduct [code]
}

-- Function to add new product
newProduct :: IO ()
newProduct = do { hSetBuffering stdout NoBuffering;
                  putStr $ msgPrimary "Cadastro de produtos\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
                  getCodeNewProduct;
                }