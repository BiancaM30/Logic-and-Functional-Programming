; 8a) Sa se elimine elementul de pe pozitia a n-a a unei liste liniare.

; Model recursiv:
;   elimin(n, l1l2..lm) = {(), daca n = 0
;			  			  {(l2...lm), daca n = 1
;			  		      {l1 U elimin(n-1, l2l3...lm), altfel
;
; Argumente: elimin(n:integer, lista:list)
; Consider ca numerotarea pozitiilor incepe de la 1

(defun elimin (n lista)
    (cond
    	((null lista) nil)
        ((equal n 1) (cdr lista))
        (t (cons (car lista) (elimin (- n 1) (cdr lista))))
    )
)

(print (elimin 1 '(5 6 7)))
(print (elimin 2 '(5 6 7)))
(print (elimin 3 '(5 6 7)))
(print (elimin 4 '(5 6 7)))









;---------------------------------------------------------------------------------------------------------------------


; 8b) Definiti o functie care determina succesorul unui numar reprezentat cifra cu cifra intr-o lista. 
; De ex: (1 9 3 5 9 9) --> (1 9 3 6 0 0)

; Functia adauga in ordine inversa elementele listei in colectoarea primita ca parametru
; Model recursiv: 
; 	invers_aux(l1...ln, col) = { col, daca lista e vida
;    						   { invers_aux(l2l3...ln, l1 '+' col), altfel
;
; Argumente: invers_aux(lista:list, col:list)

(defun invers_aux(lista col)
	(cond 
		((null lista) col)
		(t (invers_aux (cdr lista) (cons (car lista) col))) 
	)
)
; Functia principala care inverseaza elementele unei liste
; Model recursiv: 
; 	invers(l1l2...ln) = invers_aux(l1l2...ln, ())
;
; Argumente: invers(lista:list)

(defun invers (lista) 
	(invers_aux lista ())
)

; Functia returneaza 1 daca nr primit ca parametru este 10 sau 0 altfel
; div10(nr) = { 1, nr = 10
;             { 0, altfel

; Argumente: div10(nr: integer)

(defun div10(nr)
	(cond
		 ((equal nr 10) 1)
    	 (t 0)
	)
)


; Functia auxiliara care calculeaza succesorul listei primite ca parametru, avand cifrele in ordine inversa
; Model recursiv:
; 	succesor_aux(l1...ln, transport) = { (), lista e vida, transport = 0
;      								   { (1), lista e vida, transport = 1
;      								   { (l1 + transport) % 10 'U' succesor_aux(l2l3...ln, (l1 + transport)/10), altfel
; 
; Argumente: succesor_aux(lista:list, transport: integer)

(defun succesor_aux(lista transport) 
(cond 
    ((null lista) 
    	(cond 
        	((= transport 1) '(1))
        	(t nil)
        ))
   (t (cons  (mod (+ (car lista) transport) 10) (succesor_aux (cdr lista)  (div10 (+ (car lista) transport) ))))
))


; Functia principala care calculeaza succesorul listei primite ca parametru
; Model recursiv: 
; 	succesor(l1l2...ln) = invers(succesor_aux(invers(l1l2...ln), 1))
;
; Argumente: succesor(lista:list)

(defun succesor(lista) 
	(invers (succesor_aux (invers lista) 1))
)

(print (succesor '(1 9 3 5 9 9)))
(print (succesor '(5 6 7 8)))
(print (succesor '(9)))
(print (succesor '(2 9)))
(print (succesor '(1 0 8 9)))












;---------------------------------------------------------------------------------------------------------------------


; 8c) Sa se construiasca multimea atomilor unei liste.
; Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)


; Functia extrage_atomi construieste lista cu toti atomii de pe toate nivelurile, din lista primita ca parametru
; Model recursiv: 
; 	extrage_atomi(l1...ln) = { nil, daca lista e vida
;    						 { extrage_atomi(l11,l12...,l1m) '+' extrage_atomi(l2,l3...,ln), daca l1 este lista
;				   	         { l1 '+' extrage_atomi(l2,l3...ln), daca l1 este atom
;
; Argumente: extrage_atomi(lista:list)

(defun extrage_atomi(lista)
	(cond
		((null lista) nil)
		((listp (car lista)) (append (extrage_atomi (car lista)) (extrage_atomi (cdr lista))))
		(t (append (list (car lista)) (extrage_atomi (cdr lista))))
	)
)


; Scriem un predicat auxiliar 'member' care verifica
; apartenenta unui element intr-o lista.
;
; Model recursiv:
;   member(E, l1l2..ln) = {nil, daca lista e vida
;			  			  {adevarat, daca l1 = E
;			  		      {member(E,l2l3...ln), altfel
;
; Argumente: member(elem:element, lista:list)

(defun member(elem lista)
		(cond
			((null lista) nil)
			((equal elem (car lista)) T)
			(t(member elem (cdr lista)))
		)
)

; Functia creeaza o multime din elementele distincte ale listei primite ca parametru
; Model recursiv:
; 	multime(l1...ln, col) = { col, daca lista e vida
;    						( multime(l2...ln, col), daca l1 apartine colectoarei
;    						{ multime(l2...ln, l1 '+' col), altfel
;
; Argumente: multime(lista:list, col: list)

(defun multime(lista col)
	(cond
    	((null lista) col)
    	((member (car lista) col) (multime (cdr lista) col) )
    	(t (multime (cdr lista) (cons (car lista) col)))
	)
)

; Functia principala
; Model recursiv: 
; 	multime_atomi(l1...ln) = multime(extrage_atomi(l1...ln), ())
;
; Argumente: extrage_atomi(lista:list)

(defun multime_atomi(lista) 

	(multime (extrage_atomi lista) ())
)


(print (multime_atomi '(1 (2 (1 3 (2 4) 3) 1) (1 4))))
(print (multime_atomi '(1 (2 (1 9 7 7 30)))))
(print (multime_atomi '(9 (8 (7 (9 9 7))))))














;---------------------------------------------------------------------------------------------------------------------
; 8d) Sa se scrie o functie care testeaza daca o lista liniara este o multime.


; Scriem un predicat auxiliar 'member' care verifica
; apartenenta unui element intr-o lista.
;
; Model recursiv:
;   member(E, l1l2..ln) = {nil, daca lista e vida
;			  			  {adevarat, daca l1 = E
;			  		      {member(E,l2l3...ln), altfel
;
; Argumente: member(elem:element, lista:list)

(defun member(elem lista)
		(cond
			((null lista) nil)
			((equal elem (car lista)) T)
			(t(member elem (cdr lista)))
		)
)

; Model recursiv:
;   multime(l1l2..ln) = {adevarat, daca lista e vida
;			  			{nil, daca l1 este membru in (l2,...ln)
;			  		    {multime(l2...ln), altfel
;	
; Argumente: multime(lista:list)

(defun multime (lista)
	(cond
		((null lista) T)
		((member (car lista) (cdr lista)) nil)
		(t(multime (cdr lista)))
	)
)

(print (multime '(1 2 3 4)))
(print (multime '(1 7 6 1 2)))
(print (multime '(3 3 3)))
(print (multime '(1 10 11)))