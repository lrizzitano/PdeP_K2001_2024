% PARTE 1

mago(harry).
mago(draco).
mago(hermione).
mago(ron).
mago(luna).


sangre(mestiza, harry).
sangre(pura, draco).
sangre(impura, hermione).

caracteristica(harry, corajudo).
caracteristica(harry, amistoso).
caracteristica(harry, orgulloso).
caracteristica(harry, inteligente).
caracteristica(draco, orgulloso).
caracteristica(draco, inteligente).
caracteristica(hermione, inteligente).
caracteristica(hermione, orgulloso).
caracteristica(hermione, responsable).

odiariaEntrar(harry, slytherin).
odiariaEntrar(draco, hufflepuff).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

caracteristicaApropiada(gryffindor, corajudo).
caracteristicaApropiada(slytherin, orgulloso).
caracteristicaApropiada(slytherin, inteligente).
caracteristicaApropiada(ravenclaw, responsable).
caracteristicaApropiada(ravenclaw, inteligente).
caracteristicaApropiada(hufflepuff, amistoso).

permiteEntrar(Casa, Mago):-
    member(Casa, [gryffindor, ravenclaw, hufflepuff]),
    mago(Mago).

permiteEntrar(slytherin, Mago):-
    mago(Mago),
    not(sangre(impura, Mago)).

tieneCaracterApropiado(Mago, Casa):-
    mago(Mago),
    casa(Casa),
    forall(caracteristicaApropiada(Casa, Caracteristica), caracteristica(Mago, Caracteristica)).

puedeQuedarSeleccionado(hermione, gryffindor).
puedeQuedarSeleccionado(Mago, Casa):-
    mago(Mago),
    casa(Casa),
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    not(odiariaEntrar(Mago, Casa)).

cadenaDeAmistades(Magos):-
    forall(member(Mago, Magos), caracteristica(Mago, amistoso)),
    cadenaDeCasas(Magos).

cadenaDeCasas([Cabeza, Segundo|Cola]):-
    puedeQuedarSeleccionado(Cabeza, Casa),
    puedeQuedarSeleccionado(Segundo, Casa),
    cadenaDeCasas([Segundo|Cola]).
cadenaDeCasas([Cabeza, Segundo]):-
    puedeQuedarSeleccionado(Cabeza, Casa),
    puedeQuedarSeleccionado(Segundo, Casa).

% PARTE 2

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

lugarProhibido(bosque, -50).
lugarProhibido(biblioteca, -10).
lugarProhibido(tercerPiso, -75).

hizo(harry, andarFueraDeLaCama).

hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(biblioteca)).
hizo(draco, irA(mazmorras)).

hizo(ron, buenaAccion(50)).
hizo(hermione, buenaAccion(50)).
hizo(harry, buenaAccion(60)).
hizo(draco, buenaAccion(1)).

hizo(hermione, responder(dondeSeEncuentraUnBezoar, 20, snape)).
hizo(hermione, responder(comoLevitarUnaPluma, 25, slitwick)).

puntajeDeAccion(andarFueraDeLaCama, -50).
puntajeDeAccion(irA(Lugar), Puntaje):-
    lugarProhibido(Lugar, Puntaje).
puntajeDeAccion(irA(_), 0).
puntajeDeAccion(buenaAccion(Puntaje), Puntaje).
puntajeDeAccion(reponder(_, Dificultad, snape), Puntaje):-
    Puntaje is Dificultad/2.
puntajeDeAccion(responder(_, Dificultad, Profesor), Dificultad):-
    Profesor \= snape.

puntajeAlumno(Mago, Puntaje):-
    findall(Puntos, (hizo(Mago, Accion), puntajeDeAccion(Accion, Puntos)), ListaDePuntajes),
    sumlist(ListaDePuntajes, Puntaje).

esBuenAlumno(Mago):-
    mago(Mago),
    hizo(Mago, _),
    forall(hizo(Mago, Accion), (puntajeDeAccion(Accion, Puntaje), Puntaje >=0)).

esAccionRecurrente(Accion):-
    hizo(UnAlumno, Accion),
    hizo(OtroAlumno, Accion),
    UnAlumno \= OtroAlumno.

puntajeCasa(Casa, Puntaje):-
    casa(Casa),
    findall(Puntos, (esDe(Alumno, Casa), puntajeAlumno(Alumno, Puntos)), ListaDePuntajes),
    sumlist(ListaDePuntajes, Puntaje).

% En vez de sumar el puntaje total de cada alumno de la casa, suma todas las clausulas de acciones realizadas por alumnos de la casa
%
% puntajeTotalDeCasa(Casa, PuntajeTotal):-
%     esDe(_, Casa),
%     findall(Puntos,
%         (esDe(Mago, Casa), puntosQueObtuvo(Mago, _, Puntos)),
%         ListaPuntos),
%     sum_list(ListaPuntos, PuntajeTotal).

esCasaGanadora(CasaGanadora):-
    casa(CasaGanadora),
    puntajeCasa(CasaGanadora, PuntajeGanador),
    findall(Puntaje, puntajeCasa(_, Puntaje), ListaDePuntajes),
    max_member(PuntajeGanador, ListaDePuntajes).
    
    