module Product.Products (
    products,
    getProducts,
    codeProduct,
    descriptionProduct,
    priceProduct,
    taxProduct
  ) where

-- Simulation Products
products = [
    ["Produto1", "0001", "20.00", "18"],
    ["Produto2", "0002", "25.00", "18"],
    ["Produto3", "0003", "10.00", "18"],
    ["Produto4", "0004", "22.00", "18"],
    ["Produto5", "0005", "12.00", "18"],
    ["Produto6", "0006", "15.00", "18"],
    ["Produto7", "0007", "85.00", "18"],
    ["Produto8", "0008", "66.00", "18"],
    ["Produto9", "0009", "78.00", "18"],
    ["Produto10", "0010", "33.00", "18"],
    ["Produto11", "0011", "43.00", "18"],
    ["Produto12", "0012", "56.00", "18"],
    ["Produto13", "0013", "44.00", "18"],
    ["Produto14", "0014", "72.00", "18"],
    ["Produto15", "0015", "32.00", "18"],
    ["Produto16", "0016", "81.00", "18"],
    ["Produto17", "0017", "42.00", "18"],
    ["Produto18", "0018", "50.00", "18"]
  ]

type Product = (Int, String, Double, Double)

codeProduct :: Product -> Int
codeProduct (c, _, _, _) = c

descriptionProduct :: Product -> String
descriptionProduct (_, d, _, _) = d

priceProduct :: Product -> Double
priceProduct (_, _, p, _) = p

taxProduct :: Product -> Double
taxProduct (_, _, _, t) = t

getProducts :: [Product]
getProducts = [
    (0001, "Produto1", 20.00, 18.00),
    (0002, "Produto2", 25.00, 18.00),
    (0003, "Produto3", 10.00, 18.00),
    (0004, "Produto4", 22.00, 18.00),
    (0005, "Produto5", 21.00, 18.00),
    (0006, "Produto6", 15.00, 18.00),
    (0007, "Produto7", 85.00, 18.00),
    (0008, "Produto8", 66.00, 18.00)
  ]

