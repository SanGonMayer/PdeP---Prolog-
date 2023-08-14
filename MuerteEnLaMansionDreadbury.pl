viveEnLaMansionDreadbury(tiaAgatha).
viveEnLaMansionDreadbury(charles).
viveEnLaMansionDreadbury(mayordomo).

mata(Alguien, Victima):-
    viveEnLaMansionDreadbury(Alguien),
    viveEnLaMansionDreadbury(Victima),
    odia(Alguien, Victima),
    not(esMasRico(Alguien, Victima)).

odia(charles, Victima):-
    viveEnLaMansionDreadbury(Victima),
    not(odia(tiaAgatha, Victima)).

odia(tiaAgatha, Victima):-
    viveEnLaMansionDreadbury(Victima),
    Victima \= mayordomo.

odia(mayordomo, Victima):-
    odia(tiaAgatha,Victima).

esMasRico(Alguien, tiaAgatha):-
    viveEnLaMansionDreadbury(Alguien),
    not(odia(mayordomo, Alguien)).



