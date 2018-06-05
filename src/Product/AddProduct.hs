module Product.AddProduct ( addProduct ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Text.Regex.Posix
import Control.Exception

import CustomColors
import Layout
import Input
import Product.ListProducts
import Product.Products

-- Function to confirm product entry
confirmInputProduct :: [Int] -> IO ()
confirmInputProduct theInputProduct = do
  putStr $ "Confirmar entrada do produto? " ++ textRed "[s/n] "
  confirm <- getConfirm
  if confirm
    then do
      result <- setInputProduct (
          theInputProduct!!0,
          theInputProduct!!1
        )
      if result == "notExistingProduct"
        then putStr $ msgWarning "Produto não cadastrado!"
        else putStr $ msgSuccess "Entrada realizada com sucesso ✔"
      putStr $ "Deseja realizar mais entrada? " ++ textRed "[s/n] "
      getConfirmYes addProduct
    else addProduct

{-
Get quantity of products
Call putStrLn
Pass value in an array
-}
getQuantityAddProduct :: Int -> IO ()
getQuantityAddProduct x = do
  putStr "Digite a quantidade: "
  quantity <- getValue
  if quantity == ":q"
    then msgComeBack
    else if quantity == ":l"
      then do
        listProducts
        addProduct
        else if quantity == ":c"
          then addProduct
          else if ((quantity =~ "^[0-9]+$")::Bool)
            then confirmInputProduct ([x, (read quantity)])
            else do
              putStr $ msgDanger "Insira um valor inteiro válido!"
              getQuantityAddProduct x

{-
Get product code
Call getQuantityAddProduct
Pass value in an array
-}
getCodeAddProduct :: IO ()
getCodeAddProduct = do
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        addProduct
        else if code == ":c"
          then addProduct
          else if ((code =~ "^[0-9]+$")::Bool)
            then getQuantityAddProduct (read code)
            else do
              putStr $ msgDanger "Insira um valor inteiro válido!"
              getCodeAddProduct

-- Add product entry
addProduct :: IO ()
addProduct = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Entrada de produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStrLn $ "\":c\" para iniciar novamente"
  putStr $ borderLayout ++ colorDefault
  getCodeAddProduct `catch` msgException

msgException :: IOError -> IO ()
msgException _ = do
  putStr $ msgDanger "Entrada inválida!"
  addProduct
