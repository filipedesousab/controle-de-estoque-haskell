module Database.Values (
    fromSqlToInt,
    fromSqlToInt,
    fromSqlToDouble,
    fromSqlToDouble,
    fromSqlToString,
    fromSqlToString,
  ) where

import Database.HDBC

-- Transform SqlValue into Int
fromSqlToInt :: SqlValue -> Int
fromSqlToInt sv = fromSql sv

-- Transform SqlValue into Double
fromSqlToDouble :: SqlValue -> Double
fromSqlToDouble sv = fromSql sv

-- Transform SqlValue into String
fromSqlToString :: SqlValue -> String
fromSqlToString sv = fromSql sv