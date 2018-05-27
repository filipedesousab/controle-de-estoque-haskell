module Database.Values (
    fromSqlToInt,
    fromSqlToInt,
    fromSqlToDouble,
    fromSqlToDouble,
    fromSqlToString,
    fromSqlToString
  ) where

import Database.HDBC

fromSqlToInt :: SqlValue -> Int
fromSqlToInt sv = fromSql sv

fromSqlToDouble :: SqlValue -> Double
fromSqlToDouble sv = fromSql sv

fromSqlToString :: SqlValue -> String
fromSqlToString sv = fromSql sv