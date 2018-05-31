module Product.ListProducts ( listProducts ) where

import Layout
import CustomColors
import Product.Products

-- Display product list
printProduct :: [CompleteProduct] -> Int -> IO ()
printProduct [] _ = putStr ""
printProduct (item:items) i = do
  putStrLn $ "Descrição: " ++ (descriptionCompleteProduct item)
  putStrLn $ "Código: " ++ show(codeCompleteProduct item)
  putStrLn $ "Preço: R$ " ++ show(priceCompleteProduct item)
  putStrLn $ "Imposto: " ++ show(taxCompleteProduct item) ++ "%"
  putStrLn $ "Quantidade: " ++ show(quantiryCompleteProduct item)
  putStrLn "------------------------------"
  if mod i 4 == 0
    then do
      value <- getLine
      if value == ":q"
        then putStr ""
        else printProduct items (i+1)
    else printProduct items (i+1)

-- Get product list view
listProducts :: IO ()
listProducts = do
  putStrLn $ msgPrimary "Listar produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStr $ borderLayout ++ colorDefault
  produtos <- getProducts
  printProduct produtos 1