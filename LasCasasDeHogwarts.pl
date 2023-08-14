%mago(nombre, sangre, casaQueOdiaria).
mago(harry, mestiza).
mago(draco, pura).
mago(hermione, impura).

caracteristicas(harry, [coraje, amistoso, orgullo, inteligencia]).
caracteristicas(draco, [orgullo, inteligencia]).
caracteristicas(hermione, [inteligencia, orgullo, responsabilidad]).

casaQueOdiariaIr(harry, slytherin).
casaQueOdiariaIr(draco, hufflepuff).

casa(slytherin).
casa(gryffindor).
casa(ravenclaw). 
casa(hufflepuff).

caracteristicasNecesarias(slytherin, orgullo).
caracteristicasNecesarias(slytherin, inteligencia).
caracteristicasNecesarias(gryffindor, coraje).
caracteristicasNecesarias(ravenclaw, inteligencia).
caracteristicasNecesarias(ravenclaw, responsabilidad).
caracteristicasNecesarias(hufflepuff, amistoso).

puedeEntrarEnLaCasa(Mago, Casa):-
    mago(Mago, _),
    casa(Casa),
    Casa \= slytherin.
puedeEntrarEnLaCasa(Mago, slytherin):-
    mago(Mago, Sangre),
    Sangre \= impura.

tieneElCaracterApropiado(Mago, Casa):-
    mago(Mago,_),
    casa(Casa),
    forall(caracteristicasNecesarias(Casa, Requisito), tieneRequisito(Mago, Requisito)).

tieneRequisito(Mago, Requisito):-
    caracteristicas(Mago, CaracteristicasMago),
    member(Requisito, CaracteristicasMago).

puedeQuedarSeleccionado(Mago, Casa):-
    mago(Mago, _),
    casa(Casa),
    tieneElCaracterApropiado(Mago, Casa),
    puedeEntrarEnLaCasa(Mago, Casa),
    not(casaQueOdiariaIr(Mago, Casa)).
puedeQuedarSeleccionado(hermione, gryffindor).

cadenaDeAmistades(Magos):-
    sonAmistosos(Magos),
    cadenaDeCasas(Magos).
sonAmistosos(Magos):-
    forall(member(Mago, Magos), amistoso(Mago)).
amistoso(Mago):-
    tieneRequisito(Mago, amistoso).
cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    puedeQuedarSeleccionado(Mago1, Casa),
    puedeQuedarSeleccionado(Mago2, Casa),
    cadenaDeCasas([Mago2 | MagosSiguientes]).
  cadenaDeCasas([_]).
  cadenaDeCasas([]).


esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

acciones(harry, andarFueraDeLaCama, -50).
acciones(hermione, seccionRestringidaBiblioteca, -10).
acciones(draco, irAMazmorras, 0).
acciones(harry, irAlBosque, -50).
acciones(harry, irAlTercerPiso, -75).
acciones(ron, ganarAjedrezMagico, 50).
acciones(hermione, salvarAmigos, 50).
acciones(harry, ganarAVoldemort, 60).
acciones(hermione, responderPreguntas(encontrarBezoar, 20, snape)).
acciones(hermione, responderPreguntas(levitarPluma, 25, flitwick)).

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

hizoAlgunaAccion(Mago):-
    acciones(Mago,_,_).
hizoAlgoMalo(Mago):-
    acciones(Mago, _, Puntaje),
    Puntaje < 0.

esAccionRecurrente(Accion):-
    acciones(Mago, Accion, _),
    acciones(OtroMago, Accion, _),
    Mago \= OtroMago.

puntajeTotalDeCasa(Casa, PuntajeTotal):-
    esDe(_, Casa),
    findall(Puntos, (esDe(Mago, Casa), acciones(Mago, _, Puntos)), Puntajes),
    sumaPuntajes(Puntajes, PuntajeTotal).

sumaPuntajes(Puntajes, PuntajeTotal):-
    sum_list(Puntajes, PuntajeTotal).

casaGanadora(Casa):-
    puntajeTotalDeCasa(Casa, PuntajeTotal),
    not((puntajeTotalDeCasa(_, OtroPuntaje), OtroPuntaje > PuntajeTotal)).

ganarPuntosPorResponderEnClase(Mago):-



    

    


