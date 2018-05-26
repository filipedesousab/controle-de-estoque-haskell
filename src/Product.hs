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
    else getQuantityAddProduct [code]
}

addProduct :: IO ()
addProduct = do {
  hSetBuffering stdout NoBuffering;
  putStrLn $ msgLayout "Adicionar produtos ao estoque\nAqualquer momento digite \":q\" para voltar ao menu principal";
  getCodeAddProduct;
}