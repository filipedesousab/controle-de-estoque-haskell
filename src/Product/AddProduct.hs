module Product.AddProduct ( addProduct ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

import CustomColors
import Layout
import Input
import Product.ListProducts
import Product.Products

-- Function to confirm product entry
confirmInputProduct :: [String] -> IO ()
confirmInputProduct theInputProduct = do
  putStr $ "Confirmar entrada do produto? " ++ textRed "[s/n] "
  confirm <- getConfirm
  if confirm
    then do
      result <- setInputProduct (
          read(theInputProduct!!0)::Int,
          read(theInputProduct!!1)::Int
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
getQuantityAddProduct :: [String] -> IO ()
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
          else confirmInputProduct (x ++ [quantity])

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
          else getQuantityAddProduct [code]

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
  getCodeAddProduct
