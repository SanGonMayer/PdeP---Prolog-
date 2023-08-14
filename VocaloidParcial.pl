vocaloid(megurineLuka,cancion(nightFever,4)).
vocaloid(megurineLuka,cancion(foreverYoung,5)).
vocaloid(hatsuneMiku,cancion(tellYourWorld,4)).
vocaloid(gumi,cancion(foreverYoung,4)).
vocaloid(gumi,cancion(tellYourWorld,5)). 
vocaloid(seeU,cancion(novemberRain,6)).
vocaloid(seeU,cancion(nightFever,5)).

esNovedoso(UnVocaloid):-
    vocaloid(UnVocaloid, _),
    findall(Duracion, vocaloid(UnVocaloid, cancion(_,Duracion)), Duraciones),
    length(Duraciones, CantidadDeCanciones),
    sum_list(Duraciones, DuracionTotal),
    CantidadDeCanciones >= 2,
    DuracionTotal < 15.

esAcelerado(UnVocaloid):-
    vocaloid(UnVocaloid,_),
    findall(Duracion, vocaloid(UnVocaloid, cancion(_,Duracion)), Duraciones),
    cancionesConDuracionMenorACuatro(Duraciones).

cancionesConDuracionMenorACuatro([]).
cancionesConDuracionMenorACuatro([Duracion | DuracionesRestantes]):-
    Duracion =< 4,
    cancionesConDuracionMenorACuatro([DuracionesRestantes]).

concierto(mikuExpo, estadosUnidos, 2000, gigante(3,6)).
concierto(magicalMirai, japon, 3000, gigante(4,10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequeno(4)).

puedeParticiparEn(UnConcierto, hatsuneMiku):-
    concierto(UnConcierto,_,_,_).

puedeParticiparEn(UnConcierto, UnVocaloid):-
    vocaloid(UnVocaloid, cancion(_,_)),
    concierto(UnConcierto, _, _, Condicion),
    cumpleConCondicion(UnVocaloid, Condicion).

cumpleConCondicion(UnVocaloid, gigante(CantidadDeCanciones, TiempoMinimo)):-
    cantidadDeCanciones(UnVocaloid, CancionesDisponibles),
    CancionesDisponibles >= CantidadDeCanciones,
    cumpleConTiempo(UnVocaloid, TiempoTotal),
    TiempoTotal > TiempoMinimo.

cumpleConCondicion(UnVocaloid, mediano(TiempoMinimo)):-
        cumpleConTiempo(UnVocaloid, TiempoTotal),
        TiempoTotal < TiempoMinimo.

cumpleConCondicion(UnVocaloid, pequeno(TiempoMinimo)):-
            cumpleConTiempo(UnVocaloid, TiempoTotal),
            TiempoTotal > TiempoMinimo.

cantidadDeCanciones(UnVocaloid, CancionesDisponibles):-
    findall(NombreCancion, vocaloid(UnVocaloid, cancion(NombreCancion, _)), Canciones),
    length(Canciones, CancionesDisponibles).

cumpleConTiempo(UnVocaloid, TiempoTotal):-
    findall(Duracion, vocaloid(UnVocaloid, cancion(_, Duracion)), Duraciones),
    sum_list(Duraciones, TiempoTotal).

masFamoso(UnVocaloid, Fama):-
    vocaloid(UnVocaloid, _),
    cantidadDeCanciones(UnVocaloid, CancionesDisponibles),
    findall(FamaRecital, (puedeParticiparEn(UnConcierto, UnVocaloid),concierto(UnConcierto, _, FamaRecital, _)), FamaAcumulada),
    sum_list(FamaAcumulada, Fama),
    Fama is Fama * CancionesDisponibles.

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).


esElUnicoQueParticipa(UnConcierto, UnVocaloid):-
    puedeParticiparEn(UnConcierto, UnVocaloid),
    not((conoce(UnVocaloid, OtroVocaloid), puedeParticiparEn(UnConcierto, OtroVocaloid))).



    

    
    
    




    
    
    
    
