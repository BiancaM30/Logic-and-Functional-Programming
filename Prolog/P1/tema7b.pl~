% Sa se scrie un predicat care, primind o lista, intoarce multimea
% tuturor perechilor din lista.
% De ex, cu [a, b, c, d] va produce:
% [[a, b], [a, c], [a, d], [b, c], [b,d],[c, d]].
%
%
% Scriem predicatul auxiliar 'pereche' care va produce toate perechile
% formate din elementul dat si elementele listei argument
%
% Model recursiv:
%   pereche(E, l1l2..ln) = 1. [E,l1]
%			   2. pereche(E,l2l3...ln)
%
% Domeniu:element = char
%         List = element*
% Argumente: pereche(E:element, L:list, LRez: list)
% Modele de flux:(i,i,o) - nedeterminist, (i,i,i) - determinist

pereche(E, [H|_], [E,H]).
pereche(E, [_|T], LRez) :- pereche(E,T,LRez).

% Scriem predicatul auxiliar 'gasestePerechi' care va
% produce perechi intre elementele listei argument,
% folosindu-se de predicatul 'pereche' in modelul de flux(i,i,o)
%
% Model recursiv:
%   gasestePerechi(l1l2...ln) = 1.pereche(l1,l2l3...ln)
%                               2.gasestePerechi(l2l3...ln)
% Domeniu:element = char
%         List = element*
% Argumente: gasestePerechi(L:list, LRez: list)
% Modele de flux:(i,o) - nedeterminist, (i,i) - determinist

gasestePerechi([H|T], LRez) :- pereche(H, T, LRez).
gasestePerechi([_|T], LRez) :- gasestePerechi(T,LRez).

% Predicatul principal 'multimePerechi' care se va folosi de predicatul
% auxiliar 'gasestePerechi',in modelul de flux (i,o), pentru a incapsula
% toate solutiile problemei intr-o multime
%
% Model matematic:
%     multimePerechi(L) = U gasestePerechi(L)
%
% Domeniu:element = char
%         List = element*
% Argumente: toatePerechi(L:list, LRez: list)
% Modele de flux:(i,o) - determinist, (i,i) - determinist

multimePerechi(L,Multime) :- findall(LRez, gasestePerechi(L, LRez), Multime).
