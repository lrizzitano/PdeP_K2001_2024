import Data.Char
import Foreign (pooledReallocArray)
import Distribution.Backpack.PreModuleShape (PreModuleShape(preModShapeProvides))
import Language.Haskell.TH.Ppr (unboxedSumBars)
import Data.List (intersect)
import Main (isVowel)

data Barbaro = UnBarbaro {
    nombre :: String,
    fuerza :: Int,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
}

type Objeto = Barbaro -> Barbaro
type Habilidad = String

modificarFuerza :: (Int -> Int) -> Barbaro -> Barbaro
modificarFuerza unaFuncion unBarbaro = unBarbaro {fuerza = unaFuncion(fuerza unBarbaro)}

sumarHabilidad :: Habilidad -> Barbaro -> Barbaro
sumarHabilidad unaHabilidad unBarbaro = unBarbaro {habilidades = unaHabilidad : habilidades unBarbaro}

eliminarObjetos :: Barbaro -> Barbaro
eliminarObjetos unBarbaro = unBarbaro {objetos = []}


--Punto 1

espadas :: Int -> Objeto
espadas unPeso = modificarFuerza (+ 2 * unPeso)

amuletosMisticos :: Habilidad -> Objeto
amuletosMisticos  = sumarHabilidad 

varitasDefectuosas :: Objeto
varitasDefectuosas = sumarHabilidad "hacer magia" . eliminarObjetos

ardilla :: Objeto
ardilla = id

cuerda :: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto = unObjeto . otroObjeto


--Punto 2
megafono :: Objeto
megafono unBarbaro = unBarbaro {habilidades =  [concatMap (map toUpper) (habilidades unBarbaro)]}

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono


--Punto 3
type Aventura = [Evento]
type Evento = Barbaro -> Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes = tieneHabilidad "Escribir Poesia Atroz"

tieneHabilidad :: Habilidad -> Barbaro -> Bool
tieneHabilidad unaHabilidad unBarbaro = elem unaHabilidad (habilidades unBarbaro)

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = elem (nombre unBarbaro) ["Faffy", "Astro"] 

ritualDeFechorias :: Evento
ritualDeFechorias  = saqueo || gritoDeGuerra || caligrafia

saqueo :: Barbaro -> Bool
saqueo unBarbaro = tieneHabilidad "robar" unBarbaro && fuerza unBarbaro > 80

gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra unBarbaro = poderDeGritoDeGuerra unBarbaro >= 4 * length objetos

poderDeGritoDeGuerra :: Barbaro -> Int
poderDeGritoDeGuerra unBarbaro = length.concat $ habilidades unBarbaro

caligrafia :: Barbaro -> Bool
caligrafia = all (tieneMasDeTresVocales && empiezaConMayuscula) habilidades

tieneMasDeTresVocales :: Habilidad -> Bool
tieneMasDeTresVocales unaHabilidad = intersect unaHabilidad "aeiouAEIOU" > 3

empiezaConMayuscula :: Habilidad -> Bool
empiezaConMayuscula = isUpper.head

sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]
sobrevivientes unosBarbaros unaAventura = filter (\unBarbaro -> )