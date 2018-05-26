module Product
    ( newProduct
    ) where

import System.IO (stdout, hSetBuffering, BufferMode(NoBuffering))

borderLayout = "******************************"
msgLayout = borderLayout ++ "\nAdicionar um novo produto\n" ++ borderLayout

getValue = do { value <- getLine;
                if value == ""
                  then getValue
                  else return value
              }

getConfirm = do { confirm <- getValue;
                  if confirm /= "S" && confirm /= "s"
                    then do {
                      putStrLn borderLayout;
                      putStrLn "Produto não confirmado!";
                      newProduct;
                    }
                    else putStr ""
                }

newProduct :: IO ()
newProduct = do { hSetBuffering stdout NoBuffering;
                  putStrLn msgLayout;
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
                  getConfirm;
                }