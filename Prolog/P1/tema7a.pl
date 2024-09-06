% Sa se scrie un predicat care intoarce reuniunea a doua multimi.


% Scriem un predicat auxiliar 'member' care verifica
% apartenenta unui element intr-o lista.
%
% Model recursiv:
%   member(E, l1l2..ln) = {fals, daca lista e vida
%			  {adevarat, daca l1 = E
%			  {member(E,l2l3...ln), altfel
%
% Domeniu: element = integer
%          List = element*
% Argumente: member(E:element, L:list)
% Modele de flux: (i, i) - determinist, (o, i) - determinist

member(E,[E|_]):- !.
member(E,[_|T]) :- member(E,T).

% Predicatul 'reuniune' intoarce reuniunea a doua multimi reprezentate
% ca liste, folosindu-se de predicatul auxiliar 'member' in modelul de
% flux(i,i).
%
% Model recursiv:
% reuniune(l1l2...ln,L2) = {L2, daca L1 e vida
%			   {l1+reuniune(l2,..,ln,L2), daca l1 nu
%			    este membru in L2
%			   {reuniune(l2,...,ln,L2), altfel
%
% Domeniu: element = integer
%          List = element*
% Argumente: reuniune(L1:list, L2:list, L3:list)
% Modele de flux: (i,i,i) - determinist , (i,i,o) - determinist,
% (i,o,i) - determinist

reuniune([], L2, L2).

reuniune([H1|T1], L2, [H1|L3]) :-
			   not(member(H1,L2)),
			   !,
			   reuniune(T1, L2, L3).

reuniune([_|T1], L2, L3) :-
	             reuniune(T1, L2, L3).


