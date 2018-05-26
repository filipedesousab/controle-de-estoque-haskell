module Product
    ( newProduct,
      addProduct
    ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

borderLayout = "******************************"
msgLayout msg = borderLayout ++ "\n" ++ msg ++ "\n" ++ borderLayout

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
                      putStrLn borderLayout;
                      putStrLn "Ação não confirmada!";
                      func;
                    }
                    else putStr ""
                }

newProduct :: IO ()
newProduct = do { hSetBuffering stdout NoBuffering;
                  putStrLn $ msgLayout "Adicionar um novo produto";
                  putStr "Descrição do produto: ";
                  description <- getValue;
                  putStr "Código do produto: ";
                  code <- getValue;
                  putStr "Preço do produto: ";
                  price <- getValue;
                  putStr "Imposto do produto: ";
                  tax <- getValue;
                  putStrLn borderLayout;
                  putStrLn "Confirmar entrada do produto? [S/n]";
                  putStrLn (
                            "Produto: " ++ description ++
                            "\nCódigo: " ++ code ++
                            "\nPreço: " ++ price ++
                            "\nImposto: " ++ tax ++ "%"
                            );
                  getConfirm newProduct;
                }

-- Simulation Products
products = [["Produto1", "0001", "20.00", "18"], ["Produto2", "0002", "25.00", "18"], ["Produto3", "0003", "10.00", "18"], ["Produto4", "0004", "22.00", "18"], ["Produto5", "0005", "12.00", "18"], ["Produto6", "0006", "15.00", "18"], ["Produto7", "0007", "85.00", "18"], ["Produto8", "0008", "66.00", "18"], ["Produto9", "0009", "78.00", "18"], ["Produto10", "0010", "33.00", "18"], ["Produto11", "0011", "43.00", "18"], ["Produto12", "0012", "56.00", "18"], ["Produto13", "0013", "44.00", "18"], ["Produto14", "0014", "72.00", "18"], ["Produto15", "0015", "32.00", "18"], ["Produto16", "0016", "81.00", "18"], ["Produto17", "0017", "42.00", "18"], ["Produto18", "0018", "50.00", "18"]]

-- Display product list
printProduct [] _ = putStr ""
printProduct (x:xs) i = do {
  putStr $ "Nome: " ++ x!!0 ++ "\nCódigo: " ++ x!!1 ++ "\nPreço: R$" ++ x!!2 ++ "\nImposto: " ++ x!!3 ++ "%" ++"\n------------------------------\n";
  if mod i 5 == 0
    then do {
      value <- getLine;
      if value == ":q"
        then addProduct
        else printProduct xs (i+1);
    }
    else printProduct xs (i+1);
}

-- Get product list view
listProducts = do {
  putStrLn $ msgLayout "Listar produtos\nDigite \":q\" para voltar";
  printProduct products 1;
}

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
      then listProducts
      else do {
        putStr "Confirmar entrada do produto no estoque? [s/n]";
        getConfirm addProduct;
        putStrLn(show(x ++ [quantity]));
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
      then listProducts
      else getQuantityAddProduct [code]
}

addProduct :: IO ()
addProduct = do {
  hSetBuffering stdout NoBuffering;
  putStrLn $ msgLayout "Adicionar produtos ao estoque\nA qualquer momento digite:\n\":q\" para voltar ao menu principal\n\":l\" para listar os produtos";
  getCodeAddProduct;
}