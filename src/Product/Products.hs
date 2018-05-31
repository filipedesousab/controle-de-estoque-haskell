
module Product.Products (
    Product,
    ProductUpdate,
    getProducts,
    setNewProduct,
    setInputProduct,
    setOutputProduct,
    codeProduct,
    descriptionProduct,
    priceProduct,
    taxProduct
  ) where

import Database.HDBC

import Database.Conn
import Database.Values

type ProductFull = (Int, String, Double, Double, Int)
type Product = (Int, String, Double, Double)
type ProductUpdate = (Int, Int)

codeProductFull :: ProductFull -> Int
codeProductFull (c, _, _, _, _) = c

descriptionProductFull :: ProductFull -> String
descriptionProductFull (_, d, _, _, _) = d

priceProductFull :: ProductFull -> Double
priceProductFull (_, _, p, _, _) = p

taxProductFull :: ProductFull -> Double
taxProductFull (_, _, _, t, _) = t

quantiryProductFull :: ProductFull -> Int
quantiryProductFull (_, _, _, _, q) = q

codeProduct :: Product -> Int
codeProduct (c, _, _, _) = c

descriptionProduct :: Product -> String
descriptionProduct (_, d, _, _) = d

priceProduct :: Product -> Double
priceProduct (_, _, p, _) = p

taxProduct :: Product -> Double
taxProduct (_, _, _, t) = t

codeUpdadeProduct :: ProductUpdate -> Int
codeUpdadeProduct (c, _) = c

quantityUpdadeProduct :: ProductUpdate -> Int
quantityUpdadeProduct (_, q) = q

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

-- Insert input product into database
setInputProduct :: ProductUpdate -> IO String
setInputProduct item = do {
  thereAProduct <- getProductByCode (codeUpdadeProduct item);
  if (length thereAProduct) <= 0
    then return "notExistingProduct"
    else do
      conn <- connectDatabase
      state <- prepare conn "UPDATE produtos SET quantidade = quantidade+? WHERE codigo = ?;"
      result <- execute state [toSql ((quantityUpdadeProduct item)::Int), toSql ((codeUpdadeProduct item)::Int)]
      commit conn
      disconnect conn
      return ""
}

-- Update output of products in the database
updateOutputProduct :: ProductUpdate -> IO String
updateOutputProduct item = do {
  thereAProduct <- getProductByCode (codeUpdadeProduct item);
  if (length thereAProduct) <= 0
    then return "notExistingProduct"
    else if ((fromSqlToInt (thereAProduct!!4)) - (quantityUpdadeProduct item)) < 0
      then return "insufficientQuantity"
      else do
        conn <- connectDatabase
        state <- prepare conn "UPDATE produtos SET quantidade = quantidade-? WHERE codigo = ?;"
        result <- execute state [toSql ((quantityUpdadeProduct item)::Int), toSql ((codeUpdadeProduct item)::Int)]
        commit conn
        disconnect conn
        return "ok"
}

-- Call to request products
setOutputProduct :: [ProductUpdate] -> IO String
setOutputProduct [] = return "completed"
setOutputProduct (item:items) = do {
  state <- updateOutputProduct item;
  if state == "ok"
    then setOutputProduct items
    else return state
}
