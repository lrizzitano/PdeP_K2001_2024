esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).
esPersonaje(bumi).
esPersonaje(suki).

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).
controla(bumi, tierra).

% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)
visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(suki, nacionDelFuego(prision, 200)).

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Personaje, Elemento)).

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje, _)).

esMaestroPrincipiante(Personaje):-
    distinct(Personaje, controla(Personaje, _)),
    forall(controla(Personaje, Elemento), esElementoBasico(Elemento)).

esMaestroAvanzado(Personaje):-
    controla(Personaje, Elemento),
    elementoAvanzadoDe(_, Elemento).
esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

sigueA(Seguido, Seguidor):-
    esPersonaje(Seguidor),
    esPersonaje(Seguido),
    forall(visito(Seguido, Lugar), visito(Seguidor, Lugar)).
sigueA(aang, zuko).

esDignoDeConocer(temploAire(PuntoCardinal)):-
    visito(_, temploAire(PuntoCardinal)).
esDignoDeConocer(tribuAgua(norte)).
esDignoDeConocer(reinoTierra(Nombre, Estructura)):-
    visito(_, reinoTierra(Nombre, Estructura)),
    not(member(muro, Estructura)).

esPopular(Lugar):-
    visito(_, Lugar),
    findall(Personaje, visito(Personaje, Lugar), ListaDeVisitantes),
    length(ListaDeVisitantes, Largo),
    Largo > 4.