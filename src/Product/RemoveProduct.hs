module Product.RemoveProduct ( removeProduct ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

import CustomColors
import Layout
import Input
import Product.Products
import Product.ListProducts
import Product.SearchProductByCode

-- Function to confirm product removal
confirmRemoveProduct :: Int -> IO ()
confirmRemoveProduct code = do
  product <- getProductByCode code
  if length product > 0
    then do
      putStr $ msgDefault "Detalhes do produto"
      printProduct (product!!0)
      putStr $ "\nConfirmar remoção do produto? " ++ textRed "[s/n] "
      confirm <- getConfirm
      if confirm
        then do
          result <- deleteProduct code
          if result
            then putStr $ msgSuccess "Produto removido com sucesso ✔"
            else putStr $ msgWarning "Houve alguma falha ao tentar remover o produto!"
          putStrLn $ "Deseja remover outro produto? " ++ textRed "[s/n] "
          getConfirmYes removeProduct
        else removeProduct
    else do
      putStr $ msgWarning "Produto não localizado!"
      removeProduct

{-
Get product code
Call confirmRemoveProduct
Pass code::Int per parameter
-}
getCodeRemoveProduct :: IO ()
getCodeRemoveProduct = do
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        removeProduct
      else confirmRemoveProduct (read code)

-- Function to remove product
removeProduct :: IO ()
removeProduct = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Remover produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStr $ borderLayout ++ colorDefault
  getCodeRemoveProduct
