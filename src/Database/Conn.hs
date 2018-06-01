module Database.Conn ( connectDatabase ) where

import Database.HDBC
import Database.HDBC.MySQL

-- Function to get a connection to the database
connectDatabase :: IO Connection
connectDatabase = connectMySQL defaultMySQLConnectInfo {
    mysqlHost = "sql10.freemysqlhosting.net",
    mysqlUser     = "sql10240941",
    mysqlPassword = "lyTzclBLLr",
    mysqlPort = 3306,
    mysqlDatabase = "sql10240941"
  }