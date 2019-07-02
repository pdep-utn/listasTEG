continente(america,[argentina,chile,uruguay,peru,brasil,colombia]).
continente(africa,[sahara,egipto,etiopia,sudafrica,zaire,madagascar]).
continente(europa,[espania,francia,granbretania,islandia,suecia,rusia,alemania,polonia,italia]).


estaEn(Pais,Continente):-
    continente(Continente,Paises),
    member(Pais,Paises).

continenteGrande(Continente):-
	continente(Continente,Paises),
	length(Paises,Nro),
	Nro > 6.


juntarContinentes(C1,C2,TodosLosPaisesTodos):-
	continente(C1,Paises1),
	continente(C2,Paises2),
	append(Paises1,Paises2,TodosLosPaisesTodos).



esUnJugador(rojo).
esUnJugador(verde).
esUnJugador(azul).

ocupa(argentina,azul,3).
ocupa(brasil,azul,3).
ocupa(peru,azul,2).
ocupa(colombia,rojo,1).
ocupa(uruguay,rojo,3).
ocupa(chile,verde,8).
ocupa(sahara,azul,3).
ocupa(sudafrica,azul,13).


cuantosPaisesTieneElAzul(Cant):-
	paisesDelAzul(Lista),
	length(Lista,Cant).

%Lista de países que ocupa el jugador azul
paisesDelAzul(Paises):-
	findall(Pais, ocupa(Pais,azul,_) ,Paises).

% Lista de países frágiles que ocupa el jugador azul (Fragiles son las
% que tienen una sola ficha
paisesFragilesDelAzul(Paises):-
	findall(Pais, ocupa(Pais,azul,1) ,Paises).

% Lista de los paises que ocupa cualquier jugador
paisesOcupados(Paises):-
	findall(Pais, ocupa(Pais,_,_) ,Paises).

% Lista de países ocupados en los que hay más de cuatro fichas
paisesConMuchasFichas(Paises):-
	findall(Pais, (ocupa(Pais,_,C),C>4) ,Paises).

% Lista de jugadores que ocupan países.
% Cada jugador aparece en la lista tantas veces como países ocupa
jugadoresQueOcupan(Jugs):-
	findall(Jugador, ocupa(_,Jugador,_) ,Jugs).

% Lista de las cantidades de fichas que hay en los países ocupados por
% cualquier jugador
cantidades(Fichas):-
	findall(Cantidad, ocupa(_,_,Cantidad) ,Fichas).

% Cantidad total de fichas que hay en los países ocupados por
% cada jugador
totalFichasMundial(Jug,Total):-
	esUnJugador(Jug),
	findall(Cant, ocupa(_,Jug,Cant) ,Fichas),
	sumlist(Fichas,Total).


% Cantidad de fichas que tiene cada jugador en cada continente
totalFichasPorContinente(Jug,Total,Continente):-
	esUnJugador(Jug),
	continente(Continente,_),
	findall(C, (ocupa(P,Jug,C),estaEn(P,Continente)) ,Fichas),
	sumlist(Fichas,Total).

% Pattern matching en listas
cabeza([Cabeza|_],Cabeza).
cola([_|Cola],Cola).

% Recursividad en listas
ultimo([X],X).
ultimo([_|Xs],U):-ultimo(Xs,U).
