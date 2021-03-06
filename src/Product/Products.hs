
module Product.Products (
    UpdateProduct,
    CompleteProduct,
    NewProduct,
    getProducts,
    getProductByCode,
    setNewProduct,
    setInputProduct,
    setOutputProduct,
    deleteProduct,
    updateProduct,
    codeCompleteProduct,
    descriptionCompleteProduct,
    priceCompleteProduct,
    taxCompleteProduct,
    quantityCompleteProduct,
  ) where

import Database.HDBC

import Database.Conn
import Database.Values

type CompleteProduct = (Int, String, Double, Double, Int)
type NewProduct = (Int, String, Double, Double)
type UpdateProduct = (Int, Int)

codeCompleteProduct :: CompleteProduct -> Int
codeCompleteProduct (c, _, _, _, _) = c

descriptionCompleteProduct :: CompleteProduct -> String
descriptionCompleteProduct (_, d, _, _, _) = d

priceCompleteProduct :: CompleteProduct -> Double
priceCompleteProduct (_, _, p, _, _) = p

taxCompleteProduct :: CompleteProduct -> Double
taxCompleteProduct (_, _, _, t, _) = t

quantityCompleteProduct :: CompleteProduct -> Int
quantityCompleteProduct (_, _, _, _, q) = q

codeNewProduct :: NewProduct -> Int
codeNewProduct (c, _, _, _) = c

descriptionNewProduct :: NewProduct -> String
descriptionNewProduct (_, d, _, _) = d

priceNewProduct :: NewProduct -> Double
priceNewProduct (_, _, p, _) = p

taxNewProduct :: NewProduct -> Double
taxNewProduct (_, _, _, t) = t

codeUpdadeProduct :: UpdateProduct -> Int
codeUpdadeProduct (c, _) = c

quantityUpdadeProduct :: UpdateProduct -> Int
quantityUpdadeProduct (_, q) = q

-- Map SqlValue to CompleteProduct tuple
mapResults :: [SqlValue] -> CompleteProduct
mapResults x = (
    (fromSqlToInt $ x!!0),
    (fromSqlToString $ x!!1),
    (fromSqlToDouble $ x!!2),
    (fromSqlToDouble $ x!!3),
    (fromSqlToInt $ x!!4)
  )

-- Get list of products from the database
getProducts :: IO [CompleteProduct]
getProducts = do
  conn <- connectDatabase
  rows <- quickQuery' conn "SELECT * from produtos ORDER BY codigo ASC" []
  disconnect conn
  return $ map mapResults rows

-- Get single product by code
getProductByCode :: Int -> IO [CompleteProduct]
getProductByCode code = do
  conn <- connectDatabase
  select <- prepare conn "SELECT * FROM produtos WHERE codigo = ? LIMIT 1;"
  execute select [toSql (code::Int)]
  result <- fetchAllRows select
  if (length result) > 0
    then do
      disconnect conn
      return $ (mapResults $ result!!0):[]
    else do
      disconnect conn
      return []

-- Insert product into database
setNewProduct :: NewProduct -> IO String
setNewProduct item = do
  thereAProduct <- getProductByCode (codeNewProduct item)
  if (length thereAProduct) > 0
    then return "existingProduct"
    else do
      conn <- connectDatabase
      state <- prepare conn "INSERT INTO produtos VALUES (?,?,?,?,?);"
      result <- execute state [
          toSql ((codeNewProduct item)::Int),
          toSql ((descriptionNewProduct item)::String),
          toSql ((priceNewProduct item)::Double),
          toSql ((taxNewProduct item)::Double),
          toSql (0::Int)
        ]
      commit conn
      disconnect conn
      return ""

-- Insert input product into database
setInputProduct :: UpdateProduct -> IO String
setInputProduct item = do
  thereAProduct <- getProductByCode (codeUpdadeProduct item)
  if (length thereAProduct) <= 0
    then return "notExistingProduct"
    else do
      conn <- connectDatabase
      state <- prepare conn "UPDATE produtos SET quantidade = quantidade+? WHERE codigo = ?;"
      result <- execute state [
          toSql ((quantityUpdadeProduct item)::Int),
          toSql ((codeUpdadeProduct item)::Int)
        ]
      commit conn
      disconnect conn
      return ""

-- Update output of products in the database
updateOutputProduct :: UpdateProduct -> IO String
updateOutputProduct item = do
  thereAProduct <- getProductByCode (codeUpdadeProduct item)
  if (length thereAProduct) <= 0
    then return "Produto não cadastrado"
    else if ((quantityCompleteProduct $ thereAProduct!!0) - (quantityUpdadeProduct item)) < 0
      then return "Produto com quantidade insulfisiente"
      else do
        conn <- connectDatabase
        state <- prepare conn "UPDATE produtos SET quantidade = quantidade-? WHERE codigo = ?;"
        result <- execute state [
            toSql ((quantityUpdadeProduct item)::Int),
            toSql ((codeUpdadeProduct item)::Int)
          ]
        commit conn
        disconnect conn
        return "ok"

-- Called to subtract product
setOutputProduct :: [UpdateProduct] -> [[String]] -> IO [[String]]
setOutputProduct [] resp = return resp
setOutputProduct (item:items) resp = do
  state <- updateOutputProduct item
  if state == "ok"
    then setOutputProduct items resp
    else setOutputProduct items (resp ++ [[show (codeUpdadeProduct item), state]])

-- Call to remove product
deleteProduct :: Int -> IO Bool
deleteProduct code = do
  conn <- connectDatabase
  state <- prepare conn "DELETE FROM produtos WHERE codigo = ?"
  result <- execute state [toSql code]
  commit conn
  disconnect conn
  if result == 1
    then return True
    else return False

-- Update product data in the database
updateProduct :: CompleteProduct -> IO Bool
updateProduct item = do
  conn <- connectDatabase
  state <- prepare conn "UPDATE produtos SET codigo = ?, descricao = ?, preco = ?, imposto = ?, quantidade = ? WHERE codigo = ?;"
  result <- execute state [
      toSql ((codeCompleteProduct item)::Int),
      toSql ((descriptionCompleteProduct item)::String),
      toSql ((priceCompleteProduct item)::Double),
      toSql ((taxCompleteProduct item)::Double),
      toSql ((quantityCompleteProduct item)::Int),
      toSql ((codeCompleteProduct item)::Int)
    ]
  commit conn
  disconnect conn
  if result == 1
    then return True
    else return False
