module Product.SearchProductByCode ( searchProductByCode ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import Database.HDBC

import Input
import Layout
import CustomColors
import Database.Values
import Product.Products
import Product.ListProducts

-- Display product list
printProduct :: CompleteProduct -> IO ()
printProduct item = do
  putStrLn $ "\nDescrição: " ++ (descriptionCompleteProduct item)
  putStrLn $ "Código: " ++ show(codeCompleteProduct item)
  putStrLn $ "Preço: R$ " ++ show(priceCompleteProduct item)
  putStrLn $ "Imposto: " ++ show(taxCompleteProduct item) ++ "%"
  putStrLn $ "Quantidade: " ++ show(quantiryCompleteProduct item)
  putStr $ msgSuccess "Produto localizado com sucesso ✔"

-- Search single product by code
searchProductByCode :: IO ()
searchProductByCode = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Buscar produto por código"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStr $ borderLayout ++ colorDefault
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        searchProductByCode
      else do
        product <- getProductByCode (read(code)::Int)
        if length product > 0
          then printProduct (product!!0)
          else putStr $ msgWarning "Produto não localizado!"
