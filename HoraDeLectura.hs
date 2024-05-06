{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Use notElem" #-}
import Data.List

-- Tipos de datos a usar
type Titulo = String
type Autor = String
type Paginas = Int
type Libro = (Titulo, Autor, Paginas)
type Biblioteca = [Libro]

-- Accesors a los campos de los libros
titulo :: (a, b, c) -> a
titulo (unTitulo, _, _) = unTitulo
autor :: (a, b, c) -> b
autor (_, unAutor, _) = unAutor
paginas :: (a, b, c) -> c
paginas (_, _, cantPaginas) = cantPaginas

-- Funciones utiles
esDe :: Autor -> Libro -> Bool
esDe unAutor unLibro = autor unLibro == unAutor

-- Definiciones de Libros y bibliotecas
elVisitante :: Libro
elVisitante = ("El Visitante", "Stephen King", 592)
shingekiCap1 :: Libro
shingekiCap1 = ("Shingeki no Kyojin Cap 1", "Hajime Isayama", 40)
shingekiCap3 :: Libro
shingekiCap3 = ("Shingeki no Kyojin Cap 3", "Hajime Isayama", 40)
shingekiCap127 :: Libro
shingekiCap127 = ("Shingeki no Kyojin Cap 127", "Hajime Isayama", 40)
fundacion :: Libro
fundacion = ("Fundacion", "Isaac Asimov", 230)
sandmanCap5 :: Libro
sandmanCap5 = ("Sandman Cap 5", "Neil Gaiman", 35)
sandmanCap10 :: Libro
sandmanCap10 = ("Sandman Cap 10", "Neil Gaiman", 35)
sandmanCap12 :: Libro
sandmanCap12 = ("Sandman Cap 12", "Neil Gaiman", 35)
eragon :: Libro
eragon = ("Eragon", "Christopher Paolini", 544)
eldest :: Libro
eldest = ("Eldest", "Christopher Paolini", 704)
brisignr:: Libro
brisignr = ("Brisignr", "Christopher Paolini", 700)
legado :: Libro
legado = ("Legado", "Christopher Paolini", 811)
bibliotecaPdeP :: Biblioteca
bibliotecaPdeP =
    [elVisitante, shingekiCap1, shingekiCap3, shingekiCap127, fundacion, sandmanCap5, sandmanCap10, sandmanCap12] ++ sagaEragon
sagaEragon :: [Libro]
sagaEragon = [eragon, eldest, brisignr, legado]

-- Desarrollo
promedioDeHojas :: Biblioteca -> Int
promedioDeHojas unaBiblioteca = div (cantidadDeHojas unaBiblioteca) (cantidadDeLibros unaBiblioteca)
cantidadDeHojas :: Biblioteca -> Int
cantidadDeHojas unaBiblioteca = (sum.map paginas) unaBiblioteca
cantidadDeLibros :: Biblioteca -> Int
cantidadDeLibros unaBiblioteca = length unaBiblioteca

esLecturaObligatoria :: Libro -> Bool
esLecturaObligatoria unLibro = 
    esDe "Stepen King" unLibro || elem unLibro sagaEragon || unLibro == fundacion

esBibliotecaFantasiosa :: Biblioteca -> Bool
esBibliotecaFantasiosa unaBiblioteca = 
    tieneLibroDe "Christopher Paolini" unaBiblioteca || tieneLibroDe "Neil Gaiman" unaBiblioteca
tieneLibroDe :: Autor -> Biblioteca -> Bool
tieneLibroDe unAutor unaBiblioteca = any (esDe unAutor) unaBiblioteca

nombreDeLaBiblioteca :: Biblioteca -> String
nombreDeLaBiblioteca unaBibioteca = concat.titulosLibrosSinVocales $ unaBibioteca
titulosLibrosSinVocales :: Biblioteca -> [Titulo]
titulosLibrosSinVocales unaBiblioteca = map sacarVocales (titulosLibros unaBiblioteca) 
sacarVocales :: Titulo -> Titulo
sacarVocales unTitulo = filter noEsVocal unTitulo
noEsVocal :: Char -> Bool
noEsVocal unChar = not(elem unChar ['a','A','e','E','i','I','o','O','u','U'])
titulosLibros :: Biblioteca -> [Titulo]
titulosLibros unaBiblioteca = map titulo unaBiblioteca

esBibliotecaLigera :: Biblioteca -> Bool
esBibliotecaLigera unaBiblioteca = all tieneMenosDe40Paginas unaBiblioteca
tieneMenosDe40Paginas :: Libro -> Bool
tieneMenosDe40Paginas unLibro = paginas unLibro <= 40