%vocaloid(Nombre, [cancion(Nombre, Duracion)])
vocaloid(megurineLuka).
vocaloid(hatsuneMiku).
vocaloid(gumi).
vocaloid(seeU).
vocaloid(kaito).

canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).


vocaloidNovedoso(Nombre):-
    vocaloid(Nombre),
    cantidadDeCanciones(Nombre, Cantidad),
    Cantidad >= 2,
    tiempoDeCanciones(Nombre, TiempoTotal),
    TiempoTotal < 15.

cantidadDeCanciones(Nombre, CantidadDeCanciones):-
    findall(1, canta(Nombre, _), ListaDeCanciones),
    length(ListaDeCanciones, CantidadDeCanciones).

tiempoDeCanciones(Nombre, TiempoTotal):-
    findall(Duracion, canta(Nombre, cancion(_, Duracion)), ListaDeDuraciones),
    sumlist(ListaDeDuraciones, TiempoTotal).
    
cantanteAcelerado(Nombre):-
    vocaloid(Nombre),
    canta(Nombre, _),
    not((canta(Nombre, cancion(_, Duracion)), Duracion > 4)).


%concierto(Nombre, Pais, Fama, gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)).
%concierto(Nombre, Pais, Fama, mediano(DuracionTotalMaxima)).
%concierto(Nombre, Pais, Fama, pequeño(DuracionMinimaDeAlgunaCancion)).
concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequeno(4)).

puedeParticipar(hatsuneMiku, _).
puedeParticipar(NombreCantante, NombreConcierto):-
    vocaloid(NombreCantante),
    concierto(NombreConcierto, _, _, TipoDeConcierto),
    cumpleLosRequisitos(NombreCantante, TipoDeConcierto).

cumpleLosRequisitos(NombreCantante, gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)):-
    cantidadDeCanciones(NombreCantante, CantidadDeCanciones),
    CantidadDeCanciones >= CantidadMinimaDeCanciones,
    tiempoDeCanciones(NombreCantante, TiempoDeCanciones),
    TiempoDeCanciones > DuracionTotalMinima.
cumpleLosRequisitos(NombreCantante, mediano(DuracionTotalMaxima)):-
    tiempoDeCanciones(NombreCantante, TiempoDeCanciones),
    TiempoDeCanciones < DuracionTotalMaxima.
cumpleLosRequisitos(NombreCantante, pequeno(DuracionMinimaDeAlgunaCancion)):-
    canta(NombreCantante, cancion(_, Duracion)),
    Duracion > DuracionMinimaDeAlgunaCancion.

vocaloidMasFamoso(NombreCantante):-
    vocaloid(NombreCantante),
    nivelDeFama(NombreCantante, NivelDeFama),
    forall(vocaloid(Nombre), not(esMasFamoso(Nombre, NivelDeFama))).

esMasFamoso(NombreCantante, NivelDeFama):-
    nivelDeFama(NombreCantante, Fama),
    Fama > NivelDeFama.
    
nivelDeFama(NombreCantante, NivelDeFama):-
    vocaloid(NombreCantante),
    findall(Fama, (puedeParticipar(NombreCantante, NombreConcierto), concierto(NombreConcierto, _, Fama, _)), ListaDeFamaDeConciertos),
    sumlist(ListaDeFamaDeConciertos, SumaDeFama),
    cantidadDeCanciones(NombreCantante, CantidadDeCanciones),
    NivelDeFama is SumaDeFama * CantidadDeCanciones.

conoce(megurineLuka, hatsuneMiku).
conoce(gumi, seeU).
conoce(seeU, kaito).
conoce(kaito, megurineLuka).

cadenaDeConocidos(Cantante, OtroCantante):-
    conoce(Cantante, OtroCantante).
cadenaDeConocidos(Cantante, OtroCantante):-
    conoce(OtroCantanteMas, OtroCantante),
    cadenaDeConocidos(Cantante, OtroCantanteMas).