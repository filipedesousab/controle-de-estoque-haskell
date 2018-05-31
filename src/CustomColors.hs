module CustomColors (
    colorDefault,
    colorBlack,
    colorRed,
    colorGreen,
    colorYellow,
    colorBlue,
    colorMagenta,
    colorCyan,
    colorGrey,
    colorWhite,
    colorBgBlack,
    colorBgRed,
    colorBgGreen,
    colorBgYellow,
    colorBgBlue,
    colorBgMagenta,
    colorBgCyan,
    colorBgGray,
    colorBgWhite,
    textBlack,
    textRed,
    textGreen,
    textYellow,
    textBlue,
    textMagenta,
    textCyan,
    textGrey,
    bgBlack,
    bgRed,
    bgGreen,
    bgYellow,
    bgBlue,
    bgMagenta,
    bgCyan,
    bgGrey,
    colorText,
  ) where

import Data.Char

-- Color Codes
colorDefault, colorBlack, colorRed, colorGreen, colorYellow, colorBlue, colorMagenta, colorCyan, colorGrey, colorWhite :: String
colorBgBlack, colorBgRed, colorBgGreen, colorBgYellow, colorBgBlue, colorBgMagenta, colorBgCyan, colorBgGray, colorBgWhite :: String

colorDefault = "\x1b[0m"
colorBlack = "\x1b[30m"
colorRed = "\x1b[91m"
colorGreen = "\x1b[92m"
colorYellow = "\x1b[93m"
colorBlue = "\x1b[94m"
colorMagenta = "\x1b[95m"
colorCyan = "\x1b[96m"
colorGrey = "\x1b[37m"
colorWhite = "\x1b[97m"

colorBgBlack = "\x1b[40m"
colorBgRed = "\x1b[41m"
colorBgGreen = "\x1b[42m"
colorBgYellow = "\x1b[44m"
colorBgBlue = "\x1b[44m"
colorBgMagenta = "\x1b[45m"
colorBgCyan = "\x1b[46m"
colorBgGray = "\x1b[47m"
colorBgWhite = "\x1b[97m"

-- Apply color to a String
textBlack, textRed, textGreen, textYellow, textBlue, textMagenta, textCyan, textGrey :: String -> String

textBlack txt = colorBlack ++ txt ++ colorDefault
textRed txt = colorRed ++ txt ++ colorDefault
textGreen txt = colorGreen ++ txt ++ colorDefault
textYellow txt = colorYellow ++ txt ++ colorDefault
textBlue txt = colorBlue ++ txt ++ colorDefault
textMagenta txt = colorMagenta ++ txt ++ colorDefault
textCyan txt = colorCyan ++ txt ++ colorDefault
textGrey txt = colorGrey ++ txt ++ colorDefault
textWhite txt = colorWhite ++ txt ++ colorDefault

-- Apply color to a background of a String
bgBlack, bgRed, bgGreen, bgYellow, bgBlue, bgMagenta, bgCyan, bgGrey, bgWhite :: String -> String

bgBlack txt = colorBgBlack ++ txt ++ colorDefault
bgRed txt = colorBgRed ++ txt ++ colorDefault
bgGreen txt = colorBgGreen ++ txt ++ colorDefault
bgYellow txt = colorBgYellow ++ txt ++ colorDefault
bgBlue txt = colorBgBlue ++ txt ++ colorDefault
bgMagenta txt = colorBgMagenta ++ txt ++ colorDefault
bgCyan txt = colorBgCyan ++ txt ++ colorDefault
bgGrey txt = colorBgGray ++ txt ++ colorDefault
bgWhite txt = colorBgWhite ++ txt ++ colorDefault

-- Applies color to background
setBg :: String -> String -> String
setBg colorBg txt
  | map toLower colorBg == "brack" = colorBgBlack ++ txt ++ colorDefault
  | map toLower colorBg == "red" = colorBgRed ++ txt ++ colorDefault
  | map toLower colorBg == "green" = colorBgGreen ++ txt ++ colorDefault
  | map toLower colorBg == "yellow" = colorBgYellow ++ txt ++ colorDefault
  | map toLower colorBg == "blue" = colorBgBlue ++ txt ++ colorDefault
  | map toLower colorBg == "magenta" = colorBgMagenta ++ txt ++ colorDefault
  | map toLower colorBg == "cyan" = colorBgCyan ++ txt ++ colorDefault
  | map toLower colorBg == "gray" = colorBgGray ++ txt ++ colorDefault
  | map toLower colorBg == "white" = colorBgWhite ++ txt ++ colorDefault
  | otherwise = txt ++ colorDefault

-- Applies color to text and background
colorText :: String -> String -> String -> String
colorText colorTxt colorBg txt
  | map toLower colorTxt == "black" = setBg colorBg (colorBlack ++ txt)
  | map toLower colorTxt == "red" = setBg colorBg (colorRed ++ txt)
  | map toLower colorTxt == "green" = setBg colorBg (colorGreen ++ txt)
  | map toLower colorTxt == "yellow" = setBg colorBg (colorYellow ++ txt)
  | map toLower colorTxt == "blue" = setBg colorBg (colorBlue ++ txt)
  | map toLower colorTxt == "magenta" = setBg colorBg (colorMagenta ++ txt)
  | map toLower colorTxt == "cyan" = setBg colorBg (colorCyan ++ txt)
  | map toLower colorTxt == "gray" = setBg colorBg (colorGrey ++ txt)
  | map toLower colorTxt == "white" = setBg colorBg (colorWhite ++ txt)
  | otherwise = setBg colorBg txt