% BASE DE CONOCIMIENTOS: PERSONAS

% Usamos la propiedad "persona" para representar la existencia de una persona independientemente
% de su profesion, gustos o habilidades (nos permite modelar a sebastien)
persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(emmaGoldman).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano).
persona(sebastienFaure).

trabajo(bakunin, aviacionMilitar).
trabajo(ravachol, inteligenciaMilitar).
trabajo(emmaGoldman, profesoraDeJudo).
trabajo(emmaGoldman, cineasta).
trabajo(judithButler, profesoraDeJudo).
trabajo(judithButler, inteligenciaMilitar).
trabajo(elisaBachofen, ingenieraMecanica).

habilidad(bakunin, conducirAutos).
habilidad(ravachol, tiroAlBlanco).
habilidad(rosaDubovsky, construirPuentes).
habilidad(rosaDubovsky, mirarPeppaPig).
habilidad(emmaGoldman, Habilidad):-
    habilidad(judithButler, Habilidad).
habilidad(emmaGoldman, Habilidad):-
    habilidad(elisaBachofen, Habilidad).
habilidad(judithButler, judo).
habilidad(elisaBachofen, armarBombas).
habilidad(juanSuriano, judo).
habilidad(juanSuriano, armarBombas).
habilidad(juanSuriano, ringRaje).

gusto(ravachol, juegosDeAzar).
gusto(ravachol, ajedrez).
gusto(ravachol, tiroAlBlanco).
gusto(rosaDubovsky, construirPuentes).
gusto(rosaDubovsky, mirarPeppaPig).
gusto(rosaDubovsky, fisicaCuantica).
gusto(emmaGoldman, Gusto):-
    gusto(judithButler, Gusto).
gusto(judithButler, judo).
gusto(judithButler, carrerasDeAutomovilismo).
gusto(elisaBachofen, fuego).
gusto(elisaBachofen, destruccion).
gusto(juanSuriano, judo).
gusto(juanSuriano, armarBombas).
gusto(juanSuriano, ringRaje).

antecedente(bakunin, roboDeAeronaves).
antecedente(bakunin, fraude).
antecedente(bakunin, tenenciaDeCafenia).
antecedente(ravachol, falsificacionDeVacunas).
antecedente(ravachol, fraude).
antecedente(judithButler, falsificacionDeCheques).
antecedente(judithButler, fraude).
antecedente(juanSuriano, falsicacionDeDinero).
antecedente(juanSuriano, fraude).

% BASE DE CONOCIMIENTOS: VIVIENDAS

vivienda(laSeverino).
vivienda(comisaria48).
vivienda(casaDePapel).
vivienda(casaDelSolNaciente).

viveEn(bakunin, laSeverino).
viveEn(elisaBachofen, laSeverino).
viveEn(rosaDubovsky, laSeverino).
viveEn(ravachol, comisaria48).
viveEn(emmaGoldman, casaDePapel).
viveEn(juanSuriano, casaDePapel).
viveEn(judithButler, casaDePapel).

% cuartoSecreto(mts de largo, mts de ancho, vivienda)
cuartoSecreto(4, 8, laSeverino).
cuartoSecreto(5, 3, casaDePapel).
cuartoSecreto(4, 7, casaDePapel).

% tunelSecreto(mts de largo, estado, vivienda)
tunelSecreto(8, construido, laSeverino).
tunelSecreto(5, construido, laSeverino).
tunelSecreto(1, enConstruccion, laSeverino).
tunelSecreto(9, construido, casaDePapel).
tunelSecreto(2, construido, casaDePapel).
tunelSecreto(3, enConstruccion, casaDelSolNaciente).

cantidadDePasadizos(1, laSeverino).
cantidadDePasadizos(2, casaDePapel).
cantidadDePasadizos(1, casaDelSolNaciente).

% PUNTO 5
esPosibleDisidente(Persona):-
    tieneHabilidadTerrorista(Persona),
    tieneGustoRaro(Persona),
    esCriminal(Persona).

tieneHabilidadTerrorista(Persona):-
    persona(Persona),
    habilidad(Persona,Habilidad),
    habilidadTerrorista(Habilidad).

tieneGustoRaro(Persona):-
    not(gusto(Persona,_)).
tieneGustoRaro(Persona):-
    forall(gusto(Persona,Gusto),habilidad(Persona,Gusto)). % Verifica que sea bueno en todo lo que le gusta, debería ser al revés:
    % forall(habilidad(Persona, Habilidad), gusto(Persona, Habilidad)).
  
esCriminal(Persona):-
    tieneAntencedentes(Persona).
esCriminal(Persona):-
    viveEn(Persona,Vivienda),
    viveEn(OtraPersona,Vivienda),
    % Persona \= OtraPersona,
    tieneAntencedentes(OtraPersona).

tieneAntencedentes(Persona):-
    antecedente(Persona,Crimen),
    antecedente(Persona,OtroCrimen),
    Crimen \= OtroCrimen.
    
habilidadTerrorista(armarBombas).
habilidadTerrorista(tiroAlBlanco).
habilidadTerrorista(mirarPeppaPig).

% Reutilizar predicados del punto 5 en punto 7
% Agregar list_to_set en cometioMasDeUnCrimen??

% PUNTO 6

% Si se quisiera agregar un nuevo tipo de ambiente a las viviendas, primero haría falta agregar la información
% de cada uno de los ambientes a la base de conocimientos, en el caso de los bunkers podría ser un predicado que relacione
% una vivienda con los datos de perimetro de acceso y superficie del bunker: bunker(mts de perimetro, mts² de superficie, vivienda).
% Luego, para calcular la superficie de cada vivienda en en el punto 5 habría que agregar la superficie de cada bunker de la vivienda 
% con una regla que sume la lista generada con las superficies de cada bunker de esa vivienda (similar a lo que ya sucede con los cuartos secretos):
%   superficieBunkers(SuperficieBunkers, Vivienda):-
%       findall(Superficie + Perimetro, bunker(Perimetro, Superficie, Vivienda), ListaSuperciciesBunkers),
%       sumlis(ListaSuperciciesBunkers, SuperficieBunkers).

superficie(Superficie, Vivienda):-
    vivienda(Vivienda),
    superficieCuartosSecretos(SuperficieCuartosSecretos, Vivienda),
    superficieTuneles(SuperficieTuneles, Vivienda),
    superficiePasadizos(SuperficiePasadizos, Vivienda),
    Superficie is SuperficieCuartosSecretos + SuperficieTuneles + SuperficiePasadizos.

superficieCuartosSecretos(SuperficieCuartosSecretos, Vivienda):-
    findall(Largo * Ancho, cuartoSecreto(Largo, Ancho, Vivienda), ListaSuperficiesCuartosSecretos),
    sumlist(ListaSuperficiesCuartosSecretos, SuperficieCuartosSecretos).

superficieTuneles(SuperficieTuneles, Vivienda):-
    findall(2 * Longitud, tunelSecreto(Longitud, construido, Vivienda), ListaSuperficiesTuneles),
    sumlist(ListaSuperficiesTuneles, SuperficieTuneles).

superficiePasadizos(SuperficiePasadizos, Vivienda):-
    cantidadDePasadizos(SuperficiePasadizos, Vivienda).

esGuaridaRebelde(Vivienda):-
    vivienda(Vivienda),
    viveEn(Persona, Vivienda),
    esPosibleDisidente(Persona),
    superficie(Superficie, Vivienda),
    Superficie > 50.


