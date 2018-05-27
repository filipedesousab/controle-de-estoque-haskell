module Product
    ( newProduct,
      addProduct
    ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))
import CustomColors

borderLayout = "\n******************************\n"
msgLayout msg = colorText "cyan" "" (borderLayout ++ msg ++ borderLayout)
msgDanger msg = colorText "red" "" (borderLayout ++ msg ++ borderLayout)
msgSuccess msg = colorText "green" "" (borderLayout ++ msg ++ borderLayout)

-- Message displayed using @q
msgComeBack = do {
  putStrLn borderLayout;
  putStrLn "Voltando ao menu principal";
}

-- Capture value entered by user
getValue :: IO String
getValue = do { value <- getLine;
                if value == ""
                  then getValue
                  else return value
              }

getConfirm func = do { confirm <- getValue;
                        if confirm /= "S" && confirm /= "s"
                          then do {
                            putStr $ msgDanger "Ação não confirmada!";
                            func;
                          }
                          else putStr ""
                      }

confirmNewProduct theNewProduct = do {
  putStr borderLayout;
  putStrLn (
            "Produto: " ++ theNewProduct!!0 ++
            "\nCódigo: " ++ theNewProduct!!1 ++
            "\nPreço: " ++ theNewProduct!!2 ++
            "\nImposto: " ++ theNewProduct!!3 ++ "%"
            );
  putStr $ "Confirmar entrada do produto? " ++ textRed ("[s/n] ");
  getConfirm newProduct;
}

-- Display product list
printProduct [] _ = putStr ""
printProduct (x:xs) i = do {
  putStr $ "Nome: " ++ x!!0 ++ "\nCódigo: " ++ x!!1 ++ "\nPreço: R$" ++ x!!2 ++ "\nImposto: " ++ x!!3 ++ "%" ++"\n------------------------------\n";
  if mod i 5 == 0
    then do {
      value <- getLine;
      if value == ":q"
        then putStr ""
        else printProduct xs (i+1);
    }
    else printProduct xs (i+1);
}

-- Get product list view
listProducts = do {
  putStr $ msgLayout "Listar produtos\nDigite \":q\" para voltar";
  printProduct products 1;
}

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getTaxNewProduct x = do {
  putStr "Imposto do produto: ";
  tax <- getValue;
  if tax == ":q"
    then msgComeBack
    else if tax == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else confirmNewProduct (x ++ [tax])
}

{-
Get product price
Call getQuantityAddProduct
Pass value in an array
-}
getPriceNewProduct x = do {
  putStr "Preço do produto: ";
  price <- getValue;
  if price == ":q"
    then msgComeBack
    else if price == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getTaxNewProduct (x ++ [price])
}

{-
Get product code
Call getPriceNewProduct
Pass value in an array
-}
getCodeNewProduct x = do {
  putStr "Código do produto: ";
  code <- getValue;
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getPriceNewProduct (x ++ [code])
}

{-
Get product description
Call getCodeNewProduct
Pass value in an array
-}
getDescriptionNewProduct = do {
  putStr "Descrição do produto: ";
  description <- getValue;
  if description == ":q"
    then msgComeBack
    else if description == ":l"
      then do {
        listProducts;
        newProduct;
      }
      else getCodeNewProduct [description]
}

newProduct :: IO ()
newProduct = do { hSetBuffering stdout NoBuffering;
                  putStr $ msgLayout "Adicionar um novo produto\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
                  getDescriptionNewProduct;
                }

-- Simulation Products
products = [["Produto1", "0001", "20.00", "18"], ["Produto2", "0002", "25.00", "18"], ["Produto3", "0003", "10.00", "18"], ["Produto4", "0004", "22.00", "18"], ["Produto5", "0005", "12.00", "18"], ["Produto6", "0006", "15.00", "18"], ["Produto7", "0007", "85.00", "18"], ["Produto8", "0008", "66.00", "18"], ["Produto9", "0009", "78.00", "18"], ["Produto10", "0010", "33.00", "18"], ["Produto11", "0011", "43.00", "18"], ["Produto12", "0012", "56.00", "18"], ["Produto13", "0013", "44.00", "18"], ["Produto14", "0014", "72.00", "18"], ["Produto15", "0015", "32.00", "18"], ["Produto16", "0016", "81.00", "18"], ["Produto17", "0017", "42.00", "18"], ["Produto18", "0018", "50.00", "18"]]

{-
Get quantity of products
Call putStrLn
Pass value in an array
-}
getQuantityAddProduct x = do {
  putStr "Quantidade para adicionar ao estoque: ";
  quantity <- getValue;
  if quantity == ":q"
    then msgComeBack
    else if quantity == ":l"
      then do {
        listProducts;
        addProduct;
      }
      else do {
        putStr $ "Confirmar entrada do produto no estoque? " ++ textRed ("[s/n] ");
        getConfirm addProduct;
        putStrLn(show(x ++ [quantity]));
        putStr $ msgSuccess "Produto adicionado com sucesso"
      }
}

{-
Get product code
Call getQuantityAddProduct
Pass value in an array
-}
getCodeAddProduct = do {
  putStr "Insira o código do produto: ";
  code <- getValue;
  if code == ":q"
    then msgComeBack
    else if code == ":l"
      then do {
        listProducts;
        addProduct;
      }
      else getQuantityAddProduct [code]
}

addProduct :: IO ()
addProduct = do {
  hSetBuffering stdout NoBuffering;
  putStrLn $ msgLayout "Adicionar produtos ao estoque\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
  getCodeAddProduct;
}