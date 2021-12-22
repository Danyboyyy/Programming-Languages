#lang racket

;; Daniel Alejandro David Sánchez A00824566
;; ====================
;; Complete the following functions and submit your file to Canvas.
;; ====================
;; Do not change the names of the functions. 
;; Do not change the number of arguments in the functions.
;; If your file cannot be loaded by the Racket interpreted, your submission may be cancelled. Then, submit only code that works.
;; ====================
;; Grading instructions:
;; There is a series of test cases for each function. In order to state that your function "works as described", your output must be similar to the expected one in each case.

;; === sum ===

(define (sum matrix)
	(if (empty? matrix)
		0
		(if (list? (car matrix))
			(+ (sum(car matrix)) (sum(cdr matrix)))
			(+ (car matrix) (sum(cdr matrix)))
		)
	)
)

(display "=== sum ===\n")
(sum '((1 2 3) (4 5 6) (7 8 9))) ;; 45
(sum '((1 2) (30 40) (5 6) (70 80))) ;; 234
(sum '((8 9 5 6 7) (3 4 5 4 2))) ;; 53

;; === complete? ===

(define (completeAux? len graph)
	(if (null? graph)
		#t
		(if (= len (length (car graph)))
			(completeAux? (length graph) (cdr graph))
			#f
		)
	)	
)

(define (complete? graph)
	(completeAux? (length graph) graph)
)

(display "=== complete? ===\n")
(complete? '((a b c) (b a c) (c a b) (d e) (e d))) ;; #f
(complete? '((a b) (b a))) ;; #t
(complete? '( (a c) (b a) (c a))) ;; #f

;; === msort ===

(define (msortA l1 l2)
 (if (empty? l1)
		l2
		(if (empty? l2)
			l1
			(if (< (car l1) (car l2))
				(cons (car l1) (msortA (cdr l1) l2))
				(cons (car l2) (msortA l1 (cdr l2)))
			)
		)
 )
)

(define (msort lst)
	(if (or (empty? lst) (empty? (cdr lst)))
		lst
		(if (empty? (cddr lst))
			(msortA (list (car lst)) (cdr lst))
			(let ([x (ceiling (/ (length lst) 2))])
				(msortA (msort (take lst x)) (msort (drop lst x)))
			)
		)
	)
)

(display "=== msort ===\n")
(msort '()) ;; '()
(msort '(1)) ;; '(1)
(msort '(10 35 8 2.6 4.7 12)) ;; '(2.6 4.7 8 10 12 35)
(msort '(1 4 7 9 3 4 8 10)) ;; '(1 3 4 4 7 8 9 10)

;; === sold-units ===

;; This should not be done! (but it helps)
(define sales 
  '(
    (105 (10 3) (4 2) (9 3))
    (106 (6 4) (8 1) (4 6))
    (107 (9 7) (12 1) (14 1) (10 4))
    (108 (4 1))
    (109 (7 21) (10 4) (14 6) (5 3))
  )
)

(define (order id products)
	(if (null? products)
		0
		(if (= id (caar products))
			(cadar products)
			(order id (cdr products))
		)
	)
)

(define (sold-units id sales)
  	(if (null? sales)
   		0
    	(+ (order id (cdar sales)) (sold-units id (cdr sales)))
  	)
)

(display "=== sold-units ===\n")
(sold-units 2 sales) ;; 0
(sold-units 9 sales) ;; 10
(sold-units 10 sales) ;; 11
(sold-units 14 sales) ;; 7

;; === insert ===

(define (insert x tree)
	(if (or (empty? tree) (empty? (car tree)))
		(cons x '(() ()))
		(if (> x (car tree))
			(append (list (car tree)) (list (cadr tree) (insert x (caddr tree))))
			(append (list (car tree)) (list (insert x (cadr tree))) (cddr tree))
		)
	)
)

(display "=== insert ===\n")
(insert 1 '()) ;; '(1 () ())
(insert 3 '(1 () (5 () ()))) ;; '(1 () (5 (3 () ()) ()))
(insert 0 '(1 () (5 (3 () ()) (6 () ())))) ;; '(1 (0 () ()) (5 (3 () ()) (6 () ())))

;; == set ===

(define (set lst)
	(if (null? lst)
		null
		(if (and (number? (car lst)) (not (member (car lst) (cdr lst))))
			(cons (car lst) (set (cdr lst)))
			(set (cdr lst))
		)
	)
)

(display "=== set ===\n")
(set '(1 2 3 2 4 a (1 2) 5 2 3)) ;; '(1 4 5 2 3)
(set '(a b 3 4)) ;; '(3 4)
(set '(10 (a b 3) 4 (8) c d (a b 3) d c 11)) ;; '(10 4 11)

(define (union x y)
	(set (append x y))
)

(display "=== union ===\n")
(union '(1 2 3 4) '(3 4 5 6)) ;; '(1 2 3 4 5 6)
(union '(10 2 8 4) '()) ;; '(10 2 8 4)
(union '(2 a 8 4) '(b c d)) ;; '(2 8 4)

(define (intersect x)
	(if (empty? x)
		'()
		(if (member (car x) (cdr x))
			(cons (car x) (intersect (cdr x)))
			(intersect (cdr x))
		)
	)
)

(define (intersection x y)
  (set (intersect (append x y)))
)

(display "=== intersection ===\n")
(intersection '(1 2 3 4) '(3 4 5 6)) ;; '(3 4)
(intersection '(10 2 8 4) '()) ;; '()
(intersection '(2 a 8 4) '(b c 8 d)) ;; '(8)
