personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

esPeligroso(UnPersonaje):-
    realizaActividadPeligrosa(UnPersonaje).
esPeligroso(UnPersonaje):-
    tieneEmpleadosPeligrosos(UnPersonaje).

realizaActividadPeligrosa(UnPersonaje):-
    personaje(UnPersonaje, ladron(Lugares)),
    member(licorerias, Lugares).
realizaActividadPeligrosa(UnPersonaje):-
    personaje(UnPersonaje, mafioso(maton)).

tieneEmpleadosPeligrosos(UnPersonaje):-
    trabajaPara(UnPersonaje, OtroPersonaje),
    esPeligroso(OtroPersonaje).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(UnPersonaje, OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    sonParejaOAmigos(UnPersonaje, OtroPersonaje).
sonParejaOAmigos(UnPersonaje, OtroPersonaje):-
    amigo(UnPersonaje,OtroPersonaje).
sonParejaOAmigos(UnPersonaje, OtroPersonaje):-
    pareja(UnPersonaje, OtroPersonaje).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


estaEnProblemas(butch).
estaEnProblemas(UnPersonaje):-
    trabajaPara(Jefe, UnPersonaje),
    esPeligroso(Jefe),
    buscarAUnBoxeador(UnPersonaje).
estaEnProblemas(UnPersonaje):-
    trabajaPara(Jefe, UnPersonaje),
    esPeligroso(Jefe),
    encargaCuidarASuPareja(Jefe, UnPersonaje).
encargaCuidarASuPareja(Jefe, UnPersonaje):-
    pareja(Jefe, Protegido),
    encargo(Jefe, UnPersonaje, cuidar(Protegido)).
buscarAUnBoxeador(UnPersonaje):-
    personaje(Boxeador, boxeador),
    encargo(_, UnPersonaje, buscar(Boxeador, _)).

sanCayetano(UnPersonaje):-
    leDaTrabajo(UnPersonaje, OtroPersonaje),
    loTieneCerca(UnPersonaje, OtroPersonaje).
leDaTrabajo(UnPersonaje, OtroPersonaje):-
    encargo(UnPersonaje, OtroPersonaje, _).
loTieneCerca(UnPersonaje, OtroPersonaje):-
    amigo(UnPersonaje, OtroPersonaje).
loTieneCerca(UnPersonaje, OtroPersonaje):-
    trabajaPara(UnPersonaje, OtroPersonaje).

masAtareado(UnPersonaje):-
    encargo(_, UnPersonaje, _),
    findall(Tarea, encargo(_, UnPersonaje, Tarea), Encargos),
    length(Encargos, CantidadEncargos),
    forall((encargo(_, OtroPersonaje, Tarea), UnPersonaje \= OtroPersonaje), compararCantidades(CantidadEncargos, OtroPersonaje)).
compararCantidades(CantidadEncargos, OtroPersonaje):-
    findall(Tarea, encargo(_, OtroPersonaje, Tarea), OtrosEncargos), 
    length(OtrosEncargos, OtraCantidadDeEncargos), 
    CantidadEncargos >= OtraCantidadDeEncargos.

personajesRespetables(Personajes):-
    findall(Personaje, tieneNivelDeRespetoMayorA9(Personaje), Personajes).
tieneNivelDeRespetoMayorA9(Personaje):-
    esRespetable(Personaje, Nivel),
    Nivel > 9.
esRespetable(Personaje, Nivel):-
    personaje(Personaje, actriz(Peliculas)),
    length(Peliculas, CantidadPeliculas),
    Nivel is CantidadPeliculas / 10.
esRespetable(Personaje, Nivel):-
    personaje(Personaje, mafioso(resuelveProblemas)),
    Nivel is 10.
esRespetable(Personaje, Nivel):-
    personaje(Personaje, mafioso(maton)),
    Nivel is 1.
esRespetable(Personaje, Nivel):-
    personaje(Personaje, mafioso(capo)),
    Nivel is 20.

hartoDe(UnPersonaje, OtroPersonaje):-
    personaje(OtroPersonaje, _),
    encargo(_, UnPersonaje, Tarea),
    forall(encargo(_, UnPersonaje, Tarea), tieneQueInteractuarConElOtro(Tarea, OtroPersonaje)).

tieneQueInteractuarConElOtro(Tarea, OtroPersonaje):-
    requiereInteraccion(Tarea, OtroPersonaje).

requiereInteraccion(cuidar(OtroPersonaje), OtroPersonaje).
requiereInteraccion(buscar(OtroPersonaje), OtroPersonaje).
requiereInteraccion(ayudar(OtroPersonaje), OtroPersonaje).
requiereInteraccion(cuidar(amigo(OtroPersonaje, _)), OtroPersonaje).
requiereInteraccion(buscar(amigo(OtroPersonaje, _)), OtroPersonaje).
requiereInteraccion(ayudar(amigo(OtroPersonaje, _)), OtroPersonaje).

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(UnPersonaje, OtroPersonaje):-
    amigo(UnPersonaje, OtroPersonaje),
tieneCaracteristicaUnica(UnPersonaje, OtroPersonaje).

duoDiferenciable(UnPersonaje, OtroPersonaje):-
    pareja(UnPersonaje, OtroPersonaje),
    tieneCaracteristicaUnica(UnPersonaje, OtroPersonaje).

tieneCaracteristicaUnica(UnPersonaje, OtroPersonaje):-
    caracteristicas(UnPersonaje, CaracteristicasUnPersonaje),
    caracteristicas(OtroPersonaje, CaracteristicasOtroPersonaje),
    member(Caracteristica, CaracteristicasUnPersonaje),
    not(member(Caracteristica, CaracteristicasOtroPersonaje)).

    
     
    


