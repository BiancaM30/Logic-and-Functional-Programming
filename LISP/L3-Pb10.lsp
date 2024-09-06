; Definiti o functie care determina numarul nodurilor de pe nivelul k dintr-un arbore n-ar reprezentat sub forma 
; (radacina lista_noduri_subarb1 ... lista_noduri_subarbn)
; Ex: arborelele este (a (b (c)) (d) (e (f))) si  k=1 => 3 noduri 

;
; Argumente: nrNoduriNivel(L: lista, k: intreg)
; Model recursiv: nrNoduriNivel(l, k) = { 1, daca k=-1 si l este atom
;                                       { 0, daca k!=-1 si l e atom
;                                       { Σ nrNoduriNivel(li ,k-1), i=2,n  , altfel, l=(l1,l2,...ln) este lista

(defun nrNoduriNivel(L k)
	(cond
		((and (= k -1) (atom L)) 1)
		((atom L) 0)
		(t (apply #'+ (mapcar #'(lambda(L)
						(nrNoduriNivel L (- k 1))
 					  )
 					  L;
 					 )
			)
		)
	)
)

(print "Noduri de pe nivelul 0:")
(print (nrNoduriNivel '(a (b (c)) (d) (e (f))) '0))
(print "-----------------------")
(print "Noduri de pe nivelul 1:")
(print (nrNoduriNivel '(a (b (c)) (d) (e (f))) '1))
(print "-----------------------")
(print "Noduri de pe nivelul 2:")
(print (nrNoduriNivel '(a (b (c)) (d) (e (f))) '2))
(print "-----------------------")
(print "Noduri de pe nivelul 4:")
(print (nrNoduriNivel '(a (b (c)) (d) (e (f))) '4))

(print "-----------------------")
(print "-----------------------")
(print "-----------------------")
(print "Noduri de pe nivelul 2:")
(print (nrNoduriNivel '(a (b) (c (d (e))) (f (g)) (h)) '2))