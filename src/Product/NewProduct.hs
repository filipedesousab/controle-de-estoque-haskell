module Product.NewProduct ( newProduct ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Text.Regex.Posix
import Control.Exception

import CustomColors
import Layout
import Input
import Product.ListProducts
import Product.Products

-- Function to map product array to product tuple
mapArrayToProducts :: [String] -> NewProduct
mapArrayToProducts theNewProduct = (
    read (theNewProduct!!0)::Int,
    theNewProduct!!1,
    read (theNewProduct!!2)::Double,
    read (theNewProduct!!3)::Double
  )
-- Function to confirm product registration
confirmNewProduct :: [String] -> IO ()
confirmNewProduct theNewProduct = do
  putStr $ "Confirmar cadastro do produto? " ++ textRed "[s/n] "
  confirm <- getConfirm
  if confirm
    then do
      result <- setNewProduct $ mapArrayToProducts theNewProduct
      if result == "existingProduct"
        then putStr $ msgWarning "Produto já cadastrado!"
        else putStr $ msgSuccess "Cadastro realizado com sucesso ✔"
      putStrLn $ "Deseja realizar outro cadastro? " ++ textRed "[s/n] "
      getConfirmYes newProduct
    else newProduct

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getTaxNewProduct :: [String] -> IO ()
getTaxNewProduct x = do
  putStr "Digite o imposto do produto: "
  tax <- getValue
  if tax == ":q"
    then msgComeBack
    else if tax == ":l"
      then do
        listProducts
        newProduct
        else if tax == ":c"
          then newProduct
          else if ((tax =~ "^[0-9]+(.[0-9])*$")::Bool)
            then confirmNewProduct $ x ++ [tax]
            else do
              putStr $ msgDanger "Insira um valor válido!"
              getTaxNewProduct x

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getPriceNewProduct :: [String] -> IO ()
getPriceNewProduct x = do
  putStr "Digite o preço do produto: "
  price <- getValue
  if price == ":q"
    then msgComeBack
    else if price == ":l"
      then do
        listProducts
        newProduct
        else if price == ":c"
          then newProduct
          else if ((price =~ "^[0-9]+(.[0-9])*$")::Bool)
            then getTaxNewProduct $ x ++ [price]
            else do
              putStr $ msgDanger "Insira um valor válido!"
              getPriceNewProduct x

{-
Get product description
Call getPriceNewProduct
Pass value in an array
-}
getDescriptionNewProduct :: [String] -> IO ()
getDescriptionNewProduct x = do
  putStr "Digite a descrição do produto: "
  description <- getValue
  if description == ":q"
    then msgComeBack
    else if description == ":l"
      then do
        listProducts
        newProduct
        else if description == ":c"
          then newProduct
          else getPriceNewProduct $ x ++ [description]

{-
Get product code
Call getDescriptionNewProduct
Pass value in an array
-}
getCodeNewProduct :: IO ()
getCodeNewProduct = do
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        newProduct
        else if code == ":c"
          then newProduct
          else if ((code =~ "^[0-9]+$")::Bool)
            then getDescriptionNewProduct [code]
            else do
              putStr $ msgDanger "Insira um valor inteiro válido!"
              getCodeNewProduct

-- Function to add new product
newProduct :: IO ()
newProduct = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Cadastro de produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStrLn $ "\":c\" para iniciar novamente"
  putStr $ borderLayout ++ colorDefault
  getCodeNewProduct `catch` msgException

msgException :: IOError -> IO ()
msgException _ = do
  putStr $ msgDanger "Entrada inválida!"
  newProduct
