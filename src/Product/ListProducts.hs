module Product.ListProducts (listProducts) where

import Layout
import Product.Products

-- Display product list
printProduct [] _ = putStr ""
printProduct (x:xs) i = do {
  putStr $ "Nome: " ++ (descriptionProduct x) ++ "\nCódigo: " ++ show(codeProduct x) ++ "\nPreço: R$" ++ show(priceProduct x) ++ "\nImposto: " ++ show(taxProduct x) ++ "%" ++"\n------------------------------\n";
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
  printProduct getProducts 1;
}