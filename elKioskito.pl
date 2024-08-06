persona(dodain).
persona(lucas).
persona(juanC).
persona(juanFdS).
persona(leoC).
persona(martu).
persona(vale).

turno(dodain, horario(lunes, [9, 15])).
turno(dodain, horario(miercoles, [9, 15])).
turno(dodain, horario(viernes, [9, 15])).
turno(lucas, horario(martes, [10, 20])).
turno(juanC, horario(sabado, [18, 22])).
turno(juanC, horario(domingo, [18, 22])).
turno(juanFdS, horario(jueves, [10, 20])).
turno(juanFdS, horario(jueves, [12, 20])).
turno(juanFdS, horario(jueves, [10, 20])).
turno(leoC, horario(lunes, [14, 18])).
turno(leoC, horario(miercoles, [14, 18])).
turno(martu, horario(miercoles, [23, 24])).

% PUNTO 1
turno(vale, Horario):-
    turno(dodain, Horario).
turno(vale, Horario):-
    turno(juanC, Horario).

/*
  No se representan horarios que no existan o no sean definitivos,
por el principio de universo cerrado se considera falso que alguien atienda
en un horario si no este presente en la base de conocimientos.
*/

% PUNTO 2
atiende(Persona, Dia, Hora):-
    turno(Persona, horario(Dia, [HoraInicio, HoraFin])),
    between(HoraInicio, HoraFin, Hora).
    

% PUNTO 3
foreverAlone(Persona, Dia, Hora):-
    atiende(Persona, Dia, Hora),
    not((atiende(OtraPersona, Dia, Hora), Persona \= OtraPersona)).

% PUNTO 5
/*
ventas(Persona, Dia, ListaDeProductos).
golosinas(Valor).
cigarrillos(ListaDeMarcas).
bebidas(Tipo, Cantidad).
*/
ventas(dodain, 10, [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
ventas(dodain, 12, [bebidas(alcoholicas, 8), bebidas(noAlcoholicas, 1), golosinas(10)]).
ventas(martu, 12, [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
ventas(lucas, 11, [golosinas(600)]).
ventas(lucas, 18, [bebidas(noAlcoholicas, 2), cigarrillos(derby)]).

esVendedorSuertudo(Persona):-
    distinct(Persona, ventas(Persona, _, _)),
    forall(ventas(Persona, _, [Cabeza|_]), esVentaImportante(Cabeza)).

esVentaImportante(golosinas(Valor)):-
    Valor > 100.
esVentaImportante(cigarrillos(ListaDeMarcas)):-
    length(ListaDeMarcas, CantidadDeMarcas),
    CantidadDeMarcas > 2.
esVentaImportante(bebidas(Tipo, _)):-
    Tipo = alcoholicas.
esVentaImportante(bebidas(_, Cantidad)):-
    Cantidad > 5.