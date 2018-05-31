module Database.Conn ( connectDatabase ) where

import Database.HDBC
import Database.HDBC.MySQL

-- Function to get a connection to the database
connectDatabase :: IO Connection
connectDatabase = connectMySQL defaultMySQLConnectInfo {
    mysqlHost = "127.0.0.1",
    mysqlUser     = "root",
    mysqlPassword = "root",
    mysqlPort = 3306,
    mysqlDatabase = "testeHaskel"
  }