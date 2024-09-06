% a)
% Definiti un predicat care determina suma a doua numere
% scrise in reprezentare de lista.
% Ex: suma([1,7,9], [3,5,2], LRez)
% LRez = [5,3,1]

% Scriem un predicat auxiliar 'invers' care produce inversa unei liste.
% Ex: invers([1,2,3], L) => L=[3,2,1]
%
% Model recursiv:
%    invers_aux(l1l2...ln, Col) =
%              {Col, daca lista e vida
%	       {invers_aux(l2l3...ln, l1 '+' Col) altfel
%
%    invers(l1l2...ln) = invers_aux(l1l2...ln, 'MulVida')
%
% Domeniu: element = integer
%          List = element*

% Argumente: invers(L:list, LRez:list)
% Modele de flux:(i, o) - determinist, (i,i) - determinist
invers(L, LRez) :- invers_aux(L, [], LRez).

% Argumente: invers_aux(L:list, Col:list, LRez:list)
% Modele de flux:(i, i, o) - determinist, (i,i,i) - determinist
invers_aux([], Col, Col).
invers_aux([H|T], Col, LRez) :- invers_aux(T, [H|Col], LRez).


% Predicatul 'suma' determina suma a doua numere scrise in
% reprezentare de lista, folosindu-se de predicatul auxiliar
% 'invers' in modelul de flux (i,o)

% Scriem un predicat auxiliar 'suma_aux' care calculeaza suma a doua
% numere scrise sub forma de liste , in ordine inversa (aduna cifra cu
% cifra incepand de la stanga spre dreapta)
%
% Ex: suma_aux([1,2,3,4], [8, 9], 0, L) => L=[9, 1, 4, 4]
%
% Model recursiv:
%    suma_aux(l1l2...ln, l1'l2'...ln', tr) =
%     {[tr], daca L1 si L2 sunt vide, iar transportul e nenul
%     {[], daca L1 si L2 sunt vide, iar transportul e nul
%     {(l1'+tr) mod 10 '+' suma_aux([], l2'l3'..ln', (l1'+tr) div 10)
%        daca L1 e vida iar L2 e nevida
%     {(l1+tr) mod 10 '+' suma_aux(l2l3...ln, [], (l1+tr) div 10),
%	 daca L2 e vida iar L1 e nevida
%     {(l1+l1'+tr)mod10 '+'suma_aux(l2...ln,l2'...ln',(l1+l1'+tr)div 10)
%	 daca L1 si L2 nevide
%
%    suma(L1, L2) = invers(suma_aux(invers(L1), invers(L2), 0))
%
% Domeniu: element = integer
%          List = element*

% Argumente: suma_aux(L1:list, L2:list, TR: element, LRez: List)
% Modele de flux:(i, i, i, o) - determinist, (i, i, i, i) - determinist
suma_aux([], [], TR, [TR]) :- TR =\= 0,!.

suma_aux([], [], _, []) :-!.

suma_aux([], [H2|T2], TR, [H3|T3]) :-!,
	SCif is H2 + TR,
	H3 is SCif mod 10,
	Transp is SCif div 10,
	suma_aux([], T2, Transp, T3).

suma_aux([H1|T1], [], TR, [H3|T3]) :-!,
	SCif is H1 + TR,
	H3 is SCif mod 10,
	Transp is SCif div 10,
	suma_aux(T1, [], Transp, T3).

suma_aux([H1|T1], [H2|T2], TR, [H3|T3]) :-
	SCif is H1 + H2 + TR,
	H3 is SCif mod 10,
	Transp is SCif div 10,
        suma_aux(T1, T2, Transp, T3).
%
%
% Argumente: suma(L1:list, L2:list, LRez: List)
% Modele de flux:(i, i, o) - determinist, (i, i, i) - determinist
suma(L1, L2, LRez) :-
	invers(L1, L1_INV),
	invers(L2, L2_INV),

	suma_aux(L1_INV, L2_INV, 0, LREZ_INV),
	invers(LREZ_INV, LRez).

% b)
% Se da o lista eterogena, formata din numere intregi si liste de
% cifre. Sa se calculeze suma tuturor numerelor reprezentate de subliste.
% De ex:[1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2]
%
% Model recursiv:
%     sumaSubl(l1l2...ln) =
%         {[], daca L1 e vida
%         {suma(l1, sumaSubl(l2...ln)), daca l1 este lista
%         {sumaSubl(l2l3...ln), altfel
%
% Domeniu: element = integer
%          List = element*
% Lista poate contine elemente de tip intreg sau elemente de tip lista
% Argumente lista: sumaSubl(L: list, LRez: list)
% Modele de flux: (i,o) - determinist, (i,i) - determinist

sumaSubl([],[]).

sumaSubl([H|T],LRez):-
	  is_list(H),
	  !,
	  sumaSubl(T, LSum),
	  suma(H, LSum, LRez).

sumaSubl([_|T],LRez):-sumaSubl(T,LRez).
