module Database.Conn ( connectDatabase ) where

import Database.HDBC
import Database.HDBC.MySQL

-- Connection data
localhost = defaultMySQLConnectInfo {
    mysqlHost = "127.0.0.1",
    mysqlUser     = "root",
    mysqlPassword = "root",
    mysqlPort = 3306,
    mysqlDatabase = "projetoHaskell"
  }

remote = defaultMySQLConnectInfo {
    mysqlHost = "sql10.freemysqlhosting.net",
    mysqlUser     = "sql10240941",
    mysqlPassword = "lyTzclBLLr",
    mysqlPort = 3306,
    mysqlDatabase = "sql10240941"
  }

-- Function to get a connection to the database
connectDatabase :: IO Connection
connectDatabase = connectMySQL remote