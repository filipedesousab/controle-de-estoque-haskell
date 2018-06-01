module Product.ProductOutput ( productOutput ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

import CustomColors
import Layout
import Input
import Product.ListProducts
import Product.Products

-- Function to display product output failures
alertDisplay :: [[String]] -> IO ()
alertDisplay [] = putStr ""
alertDisplay (x:xs) = do
  putStrLn $ colorText "yellow" "" ("Produto: " ++ x!!0)
  putStrLn $ colorText "yellow" "" ("Mensagem: " ++ x!!1)
  alertDisplay xs

-- Function to map product array to product tuple
mapArrayToProducts :: [String] -> UpdateProduct
mapArrayToProducts theOutputProduct = (
    read(theOutputProduct!!0)::Int,
    read(theOutputProduct!!1)::Int
  )

-- Function to confirm the output of the product
outputProduct :: [[String]] -> IO ()
outputProduct theOutputProducts = do
    result <- setOutputProduct (map mapArrayToProducts theOutputProducts) []
    if length result > 0
      then do
        putStr $ blink (colorText "yellow" "" "\nAtenção!")
        putStrLn $ msgWarning "Houve falha ao aplicar ação em algum produto ✔"
        alertDisplay result
        if length theOutputProducts > length result
          then putStr $ msgSuccess "Os demoais produtos obtiveram sucesso!"
          else putStr $ msgWarning "Houve falha na saída de todos os produtos!"
      else putStr $ msgSuccess "Saída realizada com sucesso ✔"
    putStr $ "Deseja realizar mais saída? " ++ textRed "[s/n] "
    getConfirmYes (productOutput [])

{-
Get quantity of products
Call productOutput or outputProduct
Pass a list of products
-}
getQuantityAddProduct :: String -> [[String]] -> IO ()
getQuantityAddProduct y x = do
  putStr "Digite a quantidade: "
  quantity <- getValue
  if quantity == ":q"
    then msgComeBack
    else if quantity == ":l"
      then do
        listProducts
        productOutput x
      else do
        putStr $ "Deseja incluir mais itens? " ++ textRed "[s/n] "
        confirm <- getConfirm
        if confirm
          then do
            productOutput (x ++ [y:quantity:[]])
          else do
            putStr $ "Concluir pedido? " ++ textRed "[s/n] "
            getConfirmYesNo (outputProduct (x ++ [y:quantity:[]])) (productOutput [])

{-
Get product code
Call getQuantityAddProduct
Pass value in an array and a list of products
-}
getCodeAddProduct :: [[String]] -> IO ()
getCodeAddProduct x = do
  putStr "Digite o código do produto: "
  code <- getValue
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do
        listProducts
        productOutput x
      else getQuantityAddProduct code x

{-
Function for products output
Call getCodeAddProduct
Pass a list of products
-}
productOutput :: [[String]] -> IO ()
productOutput x = do
  hSetBuffering stdout NoBuffering
  putStrLn $ msgPrimary "Saída de produtos"
  putStrLn $ colorCyan ++ "A qualquer momento digite:"
  putStrLn $ "\":q\" para voltar ao menu principal"
  putStrLn $ "\":l\" para listar os produtos"
  putStr $ borderLayout ++ colorDefault
  getCodeAddProduct x
