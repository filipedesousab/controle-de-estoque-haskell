module Product.ListProducts ( listProducts, printProduct ) where

import Layout
import CustomColors
import Product.Products

-- Display product list
printProduct :: CompleteProduct -> IO ()
printProduct item = do
  putStrLn $ "\nDescrição: " ++ (descriptionCompleteProduct item)
  putStrLn $ "Código: " ++ show (codeCompleteProduct item)
  putStrLn $ "Preço: R$ " ++ show (priceCompleteProduct item)
  putStrLn $ "Imposto: " ++ show (taxCompleteProduct item) ++ "%"
  putStrLn $ "Quantidade: " ++ show (quantityCompleteProduct item)

-- Call printProduct for each product and control quantity displayed
printAllProducts :: [CompleteProduct] -> Int -> IO ()
printAllProducts [] _ = putStr ""
printAllProducts (item:items) i = do
  printProduct item
  putStrLn "------------------------------"
  if mod i 4 == 0
    then do
      value <- getLine
      if value == ":q"
        then putStr ""
        else printAllProducts items (i+1)
    else printAllProducts items (i+1)

-- Get product list view
listProducts :: IO ()
listProducts = do
  putStrLn $ msgPrimary "Listar produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStr $ borderLayout ++ colorDefault
  produtos <- getProducts
  printAllProducts produtos 1