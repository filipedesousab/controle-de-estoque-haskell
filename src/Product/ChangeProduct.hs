module Product.ChangeProduct ( changeProduct ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Text.Regex.Posix
import Control.Exception

import CustomColors
import Layout
import Input
import Database.Values
import Product.Products
import Product.ListProducts

-- Function to confirm product registration
confirmChangeProduct :: CompleteProduct -> IO ()
confirmChangeProduct product = do
  putStr $ "Confirmar alteração do produto? " ++ textRed "[s/n] "
  confirm <- getConfirm
  if confirm
    then do
      result <- updateProduct product
      if result
        then putStr $ msgSuccess "Alteração realizada com sucesso ✔"
        else putStr $ msgWarning "Houve alguma falha ao tentar alterar o produto!"
      putStrLn $ "Deseja realizar outra alteração? " ++ textRed "[s/n] "
      getConfirmYes changeProduct
    else changeProduct

{-
Get product quantity
Call getQuantityChangeProduct
Pass value in an array
-}
getQuantityChangeProduct :: CompleteProduct -> IO ()
getQuantityChangeProduct product = do
  putStr "Digite a quantidade em estoque ("
  putStr $ show $ quantityCompleteProduct product
  putStr "): "
  quantity <- getLine
  if quantity == ""
    then confirmChangeProduct product
    else if quantity == ":q"
      then msgComeBack
      else if quantity == ":l"
        then do
          listProducts
          changeProduct
        else if quantity == ":c"
          then changeProduct
          else if ((quantity =~ "^[0-9]+$")::Bool)
            then confirmChangeProduct (
                  codeCompleteProduct product,
                  descriptionCompleteProduct product,
                  priceCompleteProduct product,
                  taxCompleteProduct product,
                  read quantity::Int
                )
            else do
              putStr $ msgDanger "Insira um valor inteiro válido!"
              getQuantityChangeProduct product

{-
Get product price
Call getQuantityChangeProduct
Pass value in an array
-}
getTaxChangeProduct :: CompleteProduct -> IO ()
getTaxChangeProduct product = do
  putStr "Digite o imposto do produto ("
  putStr $ show $ taxCompleteProduct product
  putStr "%): "
  tax <- getLine
  if tax == ""
    then getQuantityChangeProduct product
    else if tax == ":q"
      then msgComeBack
      else if tax == ":l"
        then do
          listProducts
          changeProduct
        else if tax == ":c"
          then changeProduct
          else if ((tax =~ "^[0-9]+(.[0-9])*$")::Bool)
            then getQuantityChangeProduct (
                  codeCompleteProduct product,
                  descriptionCompleteProduct product,
                  priceCompleteProduct product,
                  read tax::Double,
                  quantityCompleteProduct product
                )
            else do
              putStr $ msgDanger "Insira um valor válido!"
              getTaxChangeProduct product

{-
Get product price
Call getQuantityChangeProduct
Pass value in an array
-}
getPriceChangeProduct :: CompleteProduct -> IO ()
getPriceChangeProduct product = do
  putStr "Digite o preço do produto (R$ "
  putStr $ show $ priceCompleteProduct product
  putStr "): "
  price <- getLine
  if price == ""
    then getTaxChangeProduct product
    else if price == ":q"
      then msgComeBack
      else if price == ":l"
        then do
          listProducts
          changeProduct
        else if price == ":c"
          then changeProduct
          else if ((price =~ "^[0-9]+(.[0-9])*$")::Bool)
            then getTaxChangeProduct (
                  codeCompleteProduct product,
                  descriptionCompleteProduct product,
                  read price::Double,
                  taxCompleteProduct product,
                  quantityCompleteProduct product
                )
            else do
              putStr $ msgDanger "Insira um valor válido!"
              getPriceChangeProduct product

{-
Get product description
Call getPriceChangeProduct
Pass value in an array
-}
getDescriptionChangeProduct :: CompleteProduct -> IO ()
getDescriptionChangeProduct product = do
  putStr "Digite a descrição do produto ("
  putStr $ descriptionCompleteProduct product
  putStr "): "
  description <- getLine
  if description == ""
    then getPriceChangeProduct product
    else if description == ":q"
      then msgComeBack
      else if description == ":l"
        then do
          listProducts
          changeProduct
        else if description == ":c"
          then changeProduct
          else getPriceChangeProduct (
              codeCompleteProduct product,
              description,
              priceCompleteProduct product,
              taxCompleteProduct product,
              quantityCompleteProduct product
            )

{-
Get product code
Call getDescriptionChangeProduct
Pass value in an array
-}
getCodeChangeProduct :: IO ()
getCodeChangeProduct = do
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        changeProduct
        else if code == ":c"
          then changeProduct
          else if ((code =~ "^[0-9]+$")::Bool)
            then do
              product <- getProductByCode (read code::Int)
              if length product > 0
                then getDescriptionChangeProduct (product!!0)
                else do
                  putStr $ msgWarning "Produto não cadastrado"
                  changeProduct
            else do
              putStr $ msgDanger "Insira um valor inteiro válido!"
              getCodeChangeProduct

-- Function to add new product
changeProduct :: IO ()
changeProduct = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Alterar dados de produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStrLn $ "\":c\" para iniciar novamente"
  putStr $ borderLayout ++ colorDefault
  getCodeChangeProduct `catch` msgException

msgException :: IOError -> IO ()
msgException _ = do
  putStr $ msgDanger "Entrada inválida!"
  changeProduct
