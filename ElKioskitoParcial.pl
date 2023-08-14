atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale, UnDia, HorarioInicio, HorarioFinal):-
    atiende(dodain, UnDia, HorarioInicio, HorarioFinal).
atiende(vale, UnDia, HorarioInicio, HorarioFinal):-
    atiende(juanC, UnDia, HorarioInicio, HorarioFinal).

quienAtiendeElKiosco(UnaPersona, UnDia, UnHorario):-
    atiende(UnaPersona, UnDia, HorarioInicio, HorarioFinal),
    between(HorarioInicio, HorarioFinal, UnHorario).

foreverAlone(UnaPersona, UnDia, UnHorario):-
    quienAtiendeElKiosco(UnaPersona, UnDia, UnHorario),
    not((quienAtiendeElKiosco(OtraPersona, UnDia, UnHorario), UnaPersona \= OtraPersona)).

posibilidadesDeAtencion(UnaPersona, UnDia):-
    findall(atiende(UnaPersona, UnDia, _, _), Goal, Bag)
    

    
    
    
