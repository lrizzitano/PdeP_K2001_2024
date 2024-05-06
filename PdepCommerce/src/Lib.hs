module Lib where

precioTotal :: Float -> Float -> Float -> Float -> Float
precioTotal precioUnitario cantidad descuento costoEnvio = aplicarCostoDeEnvio (aplicarDescuento precioUnitario descuento * cantidad) costoEnvio

aplicarDescuento :: Float -> Float -> Float
aplicarDescuento precio descuento = precio * descuento / 100

aplicarCostoDeEnvio :: Float -> Float -> Float
aplicarCostoDeEnvio precio costoDeEnvio = precio + costoDeEnvio

esProductoDeElite :: String -> Bool
esProductoDeElite nombre = esProductoDeLujo nombre && esProductoCodiciado nombre && (not.esProductoCorriente) nombre

esProductoDeLujo :: String -> Bool
esProductoDeLujo nombre = elem ['x', 'X', 'z', 'Z'] nombre

esProductoCodiciado :: String -> Bool
esProductoCodiciado nombre = length nombre > 10

esProductoCorriente :: String -> Bool
esProductoCorriente nombre = elem (head nombre) ['a','A','e','E','i','I','o','O','u','U']

entregaSencilla :: String -> Bool
entregaSencilla dia = (even.length) dia

productoXL :: String -> String
productoXL nombre = nombre ++ "XL"