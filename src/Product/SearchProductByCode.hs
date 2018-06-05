module Product.SearchProductByCode ( searchProductByCode ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Database.HDBC
import Text.Regex.Posix
import Control.Exception

import Input
import Layout
import CustomColors
import Database.Values
import Product.Products
import Product.ListProducts

getCode = do
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        searchProductByCode
      else if ((code =~ "^[0-9]+$")::Bool)
      then do
        product <- getProductByCode (read (code)::Int)
        if length product > 0
          then do
            printProduct $ product!!0
            putStr $ msgSuccess "Produto localizado com sucesso ✔"
          else do
            putStr $ msgWarning "Produto não localizado!"
            searchProductByCode
      else do
        putStr $ msgDanger "Insira um valor inteiro válido!"
        searchProductByCode

-- Search single product by code
searchProductByCode :: IO ()
searchProductByCode = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Buscar produto por código"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStr $ borderLayout ++ colorDefault
  getCode `catch` msgException

msgException :: IOError -> IO ()
msgException _ = do
  putStr $ msgDanger "Entrada inválida!"
  searchProductByCode
