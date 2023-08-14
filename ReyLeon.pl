%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
comio(shenzi, hormiga(conCaraDeSimba)).
pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

jugosita(UnaCucaracha):-
    comio(_, cucaracha(UnaCucaracha, Tamanio, Peso)),
    comio(_, cucaracha(_, Tamanio, OtroPeso)),
    Peso > OtroPeso.

hormigofilico(UnPersonaje):-
    comioDosHormigas(UnPersonaje).
comioDosHormigas(UnPersonaje):-
    comio(UnPersonaje, hormiga(_)),
    findall(comio(_, hormiga(_)), comio(UnPersonaje, hormiga(_)), Hormigas),
    length(Hormigas, CantidadHormigas),
    CantidadHormigas >= 2.

cucarachafobico(UnPersonaje):-
    comio(UnPersonaje, _),
    not(comioCucarachas(UnPersonaje)).
comioCucarachas(UnPersonaje):-
    comio(UnPersonaje, cucaracha(_,_,_)).

picarones(pumba).
picarones(UnosPersonajes):-
    findall(Personaje, comioJugositaORemeditos(Personaje), UnosPersonajes).
comioJugositaORemeditos(UnPersonaje):-
    comio(UnPersonaje, cucaracha(UnaCucaracha,_,_)),
    jugosita(UnaCucaracha).
comioJugositaORemeditos(UnPersonaje):-
    comio(UnPersonaje, vaquitaSanAntonio(remeditos,_)).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).



cuantoEngorda(Personaje, PesoBichos):-
    comio(Personaje, _),
    pesoDeBichos(Personaje, PesoBichos).

pesoDeBichos(Personaje, PesoBichos):-
    findall(PesoBicho, pesoPorBichoComido(Personaje, PesoBicho), PesosBichos),
    sum_list(PesosBichos, PesoBichos).
    
pesoPorBichoComido(Personaje, PesoBicho):-
    comio(Personaje, cucaracha(_,_,PesoBicho)).

pesoPorBichoComido(Personaje, PesoBicho):-
    comio(Personaje, vaquitaSanAntonio(_,PesoBicho)).

pesoPorBichoComido(Personaje, PesoBicho):-
    comio(Personaje, hormiga(_)),
    pesoHormiga(PesoBicho).

cuantoEngordaDos(Personaje, PesoTotal):-
    comio(Personaje, _),
    persigue(Personaje, _),
    pesoDeBichos(Personaje, PesoBichos),
    pesoPerseguidos(Personaje, PesoPerseguidos),
    PesoTotal is PesoBichos + PesoPerseguidos.
pesoPerseguidos(Personaje, PesoPerseguidos):-
    findall(PesoPresa, pesoPorPresa(Personaje, PesoPresa), PesosPresas),
    sum_list(PesosPresas, PesoPerseguidos).
pesoPorPresa(Personaje, PesoPresa):-
    persigue(Personaje, OtroPersonaje),
    peso(OtroPersonaje, PesoPresa).

    