; 13.Se da un arbore de tipul (2). Sa se afiseze calea de la radacina pana la un 
;nod x dat.

; Functia verifica daca un element apare intr-un arbore, pe oricare nivel
;
; Model recursiv:
;   member(E, l1 l2l3) = {nil, daca lista e vida
;			  			 {adevarat, daca l1 = E 
;			  		     {member(E,l2) sau member(E, l3), altfel
;	
; Argumente: member(elem:element, lista:list)

(defun member(elem arbore)
		(cond
			((null arbore) nil)
			((equal elem (car arbore)) T)
			(t (or (member elem (cadr arbore)) (member elem (caddr arbore))))
		)
)


;  Functia construieste intr-o lista calea de la radacina unui arbore pana la un nod dat
; 
;  Model recursiv:
;   cale(E, l1 l2l3) = { nil, daca lista e vida
;			  		   { (E), daca l1 = E 
;			  		   { l1 '+' cale(E, l2), daca E apartine de l2
;                      { l1 '+' cale(E, l3), daca E apartine de l3
;                      { nil, altfel
;	
; Argumente: member(elem:element, lista:list)

(defun cale(elem arbore)
		(cond
			((null arbore) nil)
			((equal elem (car arbore)) (list (car arbore)))
			( (member elem (cadr arbore)) (cons (car arbore) (cale elem (cadr arbore))) )
			( (member elem (caddr arbore)) (cons (car arbore) (cale elem (caddr arbore))) )
			(t nil)
		)
)

(print "Arbore 1")
(setq arbore '( A (B) (C (D) (E))))

(print "NOD A")
(print (cale 'A arbore))

(print "NOD B")
(print (cale 'B arbore))

(print "NOD C")
(print (cale 'C arbore))

(print "NOD D")
(print (cale 'D arbore))

(print "NOD E")
(print (cale 'E arbore))


(print "-----------------------")
(print "Arbore 2")
(setq arbore2 '(A (B (D (E) (F)) ()) (C (G) (H (I) ()))))

(print "NOD A")
(print (cale 'A arbore2))

(print "NOD B")
(print (cale 'B arbore2))

(print "NOD C")
(print (cale 'C arbore2))

(print "NOD D")
(print (cale 'D arbore2))

(print "NOD E")
(print (cale 'E arbore2))

(print "NOD F")
(print (cale 'F arbore2))

(print "NOD G")
(print (cale 'G arbore2))

(print "NOD H")
(print (cale 'H arbore2))

(print "NOD I")
(print (cale 'I arbore2))

(print "NOD W")
(print (cale 'W arbore2))

(print "-----------------------")
(print "Arbore 3")
(setq arbore3 '(A (B (H () (I (J) (K))) ()) (C (D () (G)) (E))))

(print "NOD A")
(print (cale 'A arbore3))

(print "NOD B")
(print (cale 'B arbore3))

(print "NOD C")
(print (cale 'C arbore3))

(print "NOD D")
(print (cale 'D arbore3))

(print "NOD E")
(print (cale 'E arbore3))

(print "NOD F")
(print (cale 'F arbore3))

(print "NOD G")
(print (cale 'G arbore3))

(print "NOD H")
(print (cale 'H arbore3))

(print "NOD I")
(print (cale 'I arbore3))

(print "NOD J")
(print (cale 'J arbore3))

(print "NOD K")
(print (cale 'K arbore3))



