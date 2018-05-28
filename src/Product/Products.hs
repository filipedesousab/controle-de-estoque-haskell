
module Product.Products (
    Product,
    getProducts,
    setNewProduct,
    codeProduct,
    descriptionProduct,
    priceProduct,
    taxProduct
  ) where

import Database.HDBC

import Database.Conn
import Database.Values

type Product = (Int, String, Double, Double)

codeProduct :: Product -> Int
codeProduct (c, _, _, _) = c

descriptionProduct :: Product -> String
descriptionProduct (_, d, _, _) = d

priceProduct :: Product -> Double
priceProduct (_, _, p, _) = p

taxProduct :: Product -> Double
taxProduct (_, _, _, t) = t

{-getProducts :: [Product]
getProducts = [
    (0001, "Produto1", 20.00, 18.00),
    (0002, "Produto2", 25.00, 18.00),
    (0003, "Produto3", 10.00, 18.00),
    (0004, "Produto4", 22.00, 18.00),
    (0005, "Produto5", 21.00, 18.00),
    (0006, "Produto6", 15.00, 18.00),
    (0007, "Produto7", 85.00, 18.00),
    (0008, "Produto8", 66.00, 18.00)
  ]-}

-- Map SqlValue to Product tuple
mapResults :: [SqlValue] -> Product
mapResults x = ((fromSqlToInt (x!!0)), (fromSqlToString (x!!1)), (fromSqlToDouble (x!!2)), (fromSqlToDouble (x!!3)))

-- Get list of products from the database
getProducts :: IO [Product]
getProducts = do {
  conn <- connectDatabase;
  rows <- quickQuery' conn "SELECT * from produtos" [];
  disconnect conn;
  return $ map mapResults rows;
}

-- Get single product by code
getProductByCode :: Int -> IO [SqlValue]
getProductByCode code = do {
  conn <- connectDatabase;
  select <- prepare conn "SELECT * FROM produtos WHERE codigo = ? LIMIT 1;";
  execute select [toSql (code::Int)];
  result <- fetchAllRows select;
  if (length result) > 0
    then do
      disconnect conn
      return (result!!0)
    else do
      disconnect conn
      return []
}

-- Insert product into database
setNewProduct :: Product -> IO String
setNewProduct item = do {
  thereAProduct <- getProductByCode (codeProduct item);
  if (length thereAProduct) > 0
    then return "existingProduct"
    else do
      conn <- connectDatabase
      state <- prepare conn "INSERT INTO produtos VALUES (?,?,?,?);"
      result <- execute state [toSql ((codeProduct item)::Int), toSql ((descriptionProduct item)::String), toSql ((priceProduct item)::Double), toSql ((taxProduct item)::Double)]
      commit conn
      disconnect conn
      return ""
}