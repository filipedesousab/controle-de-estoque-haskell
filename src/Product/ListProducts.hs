module Product.ListProducts (listProducts) where

import Layout
import Product.Products

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
  putStr $ msgPrimary "Listar produtos\nDigite \":q\" para voltar";
  printProduct products 1;
}