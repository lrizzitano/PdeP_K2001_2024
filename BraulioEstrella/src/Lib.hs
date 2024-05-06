import Text.Show.Functions

data Personaje = UnPersonaje {
  nombre           :: String,
  poderBasico      :: PoderBasico,
  superPoder       :: SuperPoder,
  superPoderActivo :: Bool,
  cantidadDeVida   :: Int
} deriving Show

type PoderBasico = Personaje -> Personaje
type SuperPoder = Personaje -> Personaje

bolaEspinosa :: PoderBasico
bolaEspinosa unPersonaje = modificarVida (max 0 . subtract 1000) unPersonaje

lluviaDeTuercas :: String -> PoderBasico
lluviaDeTuercas "Sanadora" unPersonaje = modificarVida (+ 800) unPersonaje
lluviaDeTuercas   "Dañina" unPersonaje = modificarVida (`div` 2) unPersonaje
lluviaDeTuercas          _ unPersonaje = unPersonaje

granadaDeEspinas :: Int -> SuperPoder
granadaDeEspinas radio 
    | radio > 3 = modificarNombre (++"Espina estuvo aqui").desactivarSuperEnLasUltimas
    | otherwise = bolaEspinosa

torretaCurativa :: SuperPoder
torretaCurativa unPersonaje = modificarSuperPoderActivo (True) . modificarVida (*2) $ unPersonaje

desactivarSuperEnLasUltimas :: Personaje -> Personaje
desactivarSuperEnLasUltimas unPersonaje
    | estaEnLasUltimas unPersonaje = unPersonaje { superPoderActivo = False, cantidadDeVida = 0 }
    | otherwise = unPersonaje

modificarVida :: (Int -> Int) -> Personaje -> Personaje
modificarVida unaFuncion unPersonaje = unPersonaje { cantidadDeVida = unaFuncion . cantidadDeVida $ unPersonaje }

modificarNombre :: (String -> String) -> Personaje -> Personaje
modificarNombre unaFuncion unPersonaje = unPersonaje { nombre = unaFuncion . nombre $ unPersonaje }

modificarPoderBasico :: (PoderBasico -> PoderBasico) -> Personaje -> Personaje
modificarPoderBasico unaFuncion unPersonaje = unPersonaje { poderBasico = unaFuncion . poderBasico $ unPersonaje }

modificarSuperPoderActivo :: Bool -> Personaje -> Personaje
modificarSuperPoderActivo unBool unPersonaje = unPersonaje { superPoderActivo = unBool }


atacarConSuperPoder :: Personaje -> Personaje -> Personaje
atacarConSuperPoder unPersonaje contrincante 
    | superPoderActivo unPersonaje = poderBasico unPersonaje . superPoder unPersonaje $ contrincante
    | otherwise = contrincante

estaEnLasUltimas :: Personaje -> Bool
estaEnLasUltimas unPersonaje = cantidadDeVida unPersonaje < 800

pamela :: Personaje
pamela = UnPersonaje {
  nombre = "Pamela",
  poderBasico = lluviaDeTuercas "Sanadora",
  superPoder =  torretaCurativa,
  superPoderActivo = False,
  cantidadDeVida = 9600
}

espina :: Personaje
espina = UnPersonaje {
  nombre = "Espina",
  poderBasico = bolaEspinosa,
  superPoder = granadaDeEspinas 5,
  superPoderActivo = True,
  cantidadDeVida = 4800
}