import Data.Time (TimeZone(timeZoneMinutes))
import Language.Haskell.TH (compE)
data Participante = UnParticipante {
    nombre :: String,
    trucos :: [Truco],
    especialidad :: Plato
}

data Plato = UnPlato{
    dificultad :: Int,
    componentes :: [Componente]
} deriving Show

type Truco = Plato -> Plato

type Componente = (Ingrediente, Gramos)
type Ingrediente = String
type Gramos = Int

modificarDificultad :: (Int -> Int) -> Plato -> Plato
modificarDificultad unaFuncion unPlato = unPlato {dificultad = unaFuncion.dificultad $ unPlato}

modificarComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
modificarComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion.componentes $ unPlato}

añadirComponente :: Ingrediente -> Gramos -> Plato -> Plato
añadirComponente unIngrediente unosGramos = modificarComponentes ((unIngrediente, unosGramos) :) 

-- Parte A

endulzar :: Gramos -> Truco
endulzar = añadirComponente "azucar"

salar :: Gramos -> Truco
salar = añadirComponente "sal"

darSabor :: Gramos -> Gramos -> Truco
darSabor gramosDeSal gramosDeAzucar = salar gramosDeSal . endulzar gramosDeAzucar 

duplicarPorcion :: Truco
duplicarPorcion  = modificarComponentes (map duplicarComponente)

duplicarComponente :: Componente -> Componente
duplicarComponente (unIngrediente, unosGramos) = (unIngrediente, 2 * unosGramos)

simplificar :: Truco
simplificar unPlato
    | esComplejo unPlato = modificarDificultad (const 5) . modificarComponentes (filter tieneDiezGramosOMas) $ unPlato
    | otherwise = unPlato

tieneDiezGramosOMas :: Componente -> Bool
tieneDiezGramosOMas (_ , gramos) = gramos >= 10

esVegano :: Plato -> Bool
esVegano = tieneIngredientes ["carne", "huevos", "leche", "manteca"]

esSinTacc :: Plato -> Bool
esSinTacc = tieneIngredientes ["harina"]

tieneIngredientes :: [Ingrediente] -> Plato -> Bool
tieneIngredientes unosIngredientes unPlato = any (incluidoEn unPlato) unosIngredientes

incluidoEn :: Plato -> Ingrediente -> Bool
incluidoEn unPlato unIngrediente = elem unIngrediente (ingredientes unPlato)

ingredientes :: Plato -> [Ingrediente]
ingredientes = map fst . componentes

esComplejo :: Plato -> Bool
esComplejo unPlato = (length.componentes) unPlato > 5 && dificultad unPlato > 7

noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = any esMuchaSal (componentes unPlato)

esMuchaSal :: Componente -> Bool
esMuchaSal ("sal", gramos) = gramos > 2
esMuchaSal _ = False

-- Parte B

pepe :: Participante
pepe = UnParticipante "Pepe Ronccino" [darSabor 2 5, simplificar, duplicarPorcion] papasHipertensas

papasHipertensas :: Plato
papasHipertensas = UnPlato 8 [("papa", 500), ("sal", 10), ("oregano", 2), ("aceite", 7), ("amor", 8)]

-- Parte C

cocinar :: Participante -> Plato
cocinar (UnParticipante _ trucos especialidad) = foldr ($) especialidad trucos

esMejorQue :: Plato -> Plato -> Bool
esMejorQue unPlato otroPlato = dificultad unPlato > dificultad otroPlato && sumaDePesos unPlato > sumaDePesos otroPlato

sumaDePesos :: Plato -> Int
sumaDePesos (UnPlato _ componentes) = sum.map snd $ componentes

participanteEstrella :: [Participante] -> Participante
participanteEstrella [participante] = participante
participanteEstrella (cabeza : cola) = foldr competir cabeza cola

competir :: Participante -> Participante -> Participante
competir unParticipante otroParticipante 
    | esMejorQue (cocinar unParticipante) (cocinar otroParticipante) = unParticipante
    |otherwise = otroParticipante

-- Parte D

platinum :: Plato
platinum = UnPlato 10 (componentesPlatinum [1..])

componentesPlatinum :: [Int] -> [Componente]
componentesPlatinum = map crearComponentePlatinum 

crearComponentePlatinum :: Int -> Componente
crearComponentePlatinum unNumero = ("Ingrediente " ++ show unNumero, unNumero)