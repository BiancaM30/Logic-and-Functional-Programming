; 1a)
; Sa se insereze intr-o lista liniara un atom a dat dupa al 2-lea, al 4-lea, al 6-lea,....element.

; Model recursiv:
;   insert_el (l1l2...ln, elem, p) = { (), daca lista e vida
;                                    { l1 '+' e '+' insert_el(l2...ln, e, p+1), daca n%2=0, 
;                                                         unde n reprezinta indicele elementului din lista
;                                    { l1 '+' insert_el(l2...ln, e, p+1), altfel
;   solve (l, e) = insert_el(l, e, 1)
(defun insert_el (l e p)
    (cond
        ((null l) nil)
        ((equal (mod p 2) 0) (cons (car l) (cons e (insert_el (cdr l) e (+ p 1)))))
        (T (cons (car l) (insert_el (cdr l) e (+ p 1))))
    )
)

(defun solve (l e)
    (insert_el l e 1)
)

(print (solve '(1 2 3 4 5 6 7 8) 78))
;=> (1 2 78 3 4 78 5 6 78 7 8 78) 







;------------------------------------------------------------------------------------------
; 1b)
;Definiti o functie care obtine dintr-o lista data lista tuturor atomilor 
;care apar, pe orice nivel, dar in ordine inversa.
; De exemplu: (((A B) C) (D E)) --> (E D C B A)

; Model recursiv:
;  ?? my_append (l1l2...ln, k) = { k
;                                { l1 '+' my_append(l2...ln, k)
; (my_append (1 2 3) 4) => (1 2 3 . 4)

;   all_atoms(l1l2...ln) = { (), daca lista e vida
;                          { my_append(all_atoms(l2...ln),  all_atoms(l1)), daca l1 e lista   
;                          {  my_append((all_atoms(l2...ln) (l1))

(defun my_append (l k)
    (if (null l) 
        k
        (cons (car l) (my_append (cdr l) k))
    )
)

(print (my_append '(1 2 3) 4))

(defun all_atoms (l)
    (cond
        ((null l) nil)
        ((listp (car l)) (my_append (all_atoms (cdr l)) (all_atoms (car l))))
        (T (my_append (all_atoms (cdr l)) (list (car l))))
    )
)

(print (all_atoms '(((A B) C) (D E))))







;------------------------------------------------------------------------------------------
; c) Definiti o functie care intoarce cel mai mare divizor comun al numerelor 
; dintr-o lista neliniara

; Calculam Cmmdc prin impartiri
; Model recursiv:
;  gcd (a b) = { nil, daca a si b nu sunt numere
;              { b, daca a nu e numar    
;              { a, daca b nu e numar  
;              { a, daca b = 0  
;              { gcd (b, a%b), altfel  
;
; list_gcd(l1l2...ln) = { l1 , daca lista mai are un singur atom 
;                       { _gcd((list_gcd(l1)) , list_gcd(l2...ln)), daca l1 este lista
;                       { _gcd(l1, list_gcd(l2...ln)), altfel
(defun _gcd (a b)
    (cond
        ((and (not (numberp a)) (not (numberp b))) nil)
        ((not (numberp a)) b)
        ((not (numberp b)) a)
        ((equal b 0) a)
        (T (_gcd b (mod a b)))
    )
)

(defun list_gcd (l)
    (cond
        ((and (atom (car l)) (null (cdr l))) (car l))
        ((listp (car l)) (_gcd (list_gcd (car l)) (list_gcd (cdr l))))
        (T (_gcd (car l) (list_gcd (cdr l))))
    )
)

(print (list_gcd '(24 ( 16 (12 A B)) 72)))
;=> 4









;------------------------------------------------------------------------------------------
; d)
; Sa se scrie o functie care determina numarul de aparitii ale unui atom dat 
; intr-o lista neliniara.


(defun occurences (l e)
    (cond
        ((and (atom l) (equal l e)) 1)
        ((atom l) 0)
        (T (apply '+ (mapcar #'(lambda (a) (occurences a e)) l)))
    )
)

(print (occurences '(1 (3 (5 4 3) (5 3)) 3 3) 3))
;=> 5