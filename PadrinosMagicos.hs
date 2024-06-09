import Language.Haskell.TH.Syntax (Con)
data Chico = UnChico {
    nombre :: String,
    edad :: Int,
    habilidades :: [Habilidad],
    deseos :: [Deseo]
}

type Habilidad = String
type Deseo = Chico -> Chico

modificarEdad :: (Int -> Int) -> Chico -> Chico
modificarEdad unaFuncion unChico = unChico {edad = unaFuncion.edad $ unChico}

modificarHabilidades :: ([Habilidad] -> [Habilidad]) -> Chico -> Chico
modificarHabilidades unaFuncion unChico = unChico {habilidades = unaFuncion.habilidades $ unChico}

-- Parte A

timmy :: Chico
timmy = UnChico "Timmy" 10 ["mirar television", "jugar en la pc"] [serMayor]

aprenderHabilidades :: [Habilidad] -> Deseo
aprenderHabilidades habilidades = modificarHabilidades (++ habilidades)

serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = modificarHabilidades (++ jugarTodosLosNFS)

jugarTodosLosNFS :: [Habilidad]
jugarTodosLosNFS = map jugarVersionNFS [1..]

jugarVersionNFS :: Int -> Habilidad
jugarVersionNFS unNumero = "jugar Need For Speed " ++ show unNumero 

serMayor :: Deseo
serMayor = modificarEdad (const 18)

wanda :: Chico -> Chico
wanda = madurar.cumplirDeseo

madurar :: Chico -> Chico
madurar = modificarEdad (+ 1)

cumplirDeseo :: Chico -> Chico
cumplirDeseo unChico = (head.deseos) unChico unChico

cosmo :: Chico -> Chico
cosmo = modificarEdad (subtract 1)

muffinMagico :: Chico -> Chico
muffinMagico unChico = todosLosDeseos unChico unChico

todosLosDeseos :: Chico -> Deseo
todosLosDeseos unChico = foldr (.) (head.deseos $ unChico) (deseos unChico)

-- Parte B

data Chica = UnaChica {
    nombreChica :: String,
    condicion :: Condicion
}

type Condicion = Chico -> Bool

trixie = UnaChica "Trixie Tang" noEsTimmy
vicky = UnaChica "Vicky" (tieneHabilidad "ser un supermodelo noruego")

noEsTimmy :: Condicion
noEsTimmy = (== "Timmy").nombre

tieneHabilidad :: Habilidad -> Chico -> Bool
tieneHabilidad unaHabilidad unChico = elem unaHabilidad (habilidades unChico)

esSuperMaduro :: Chico -> Bool
esSuperMaduro unChico = esMayorDeEdad unChico  && tieneHabilidad "manejar" unChico 

esMayorDeEdad :: Chico -> Bool
esMayorDeEdad = (>18).edad

-- pattern matching para lista unitaria, guardas para ver si head cumple con condicion, recursividad para interar en la lista en caso de que no cumpla
quienConquistaA :: Chica -> [Chico] -> Chico





