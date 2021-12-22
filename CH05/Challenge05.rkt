#lang racket

;; ====================
;; Complete the following functions and submit your file to Canvas.
;; ====================
;; Do not change the names of the functions. 
;; Do not change the number of arguments in the functions.
;; If your file cannot be loaded by the Racket interpreted, your submission may be cancelled. Then, submit only code that works.
;; ====================
;; Grading instructions:
;; There is a series of test cases for each function. In order to state that your function "works as described", your output must be similar to the expected one in each case.

;; === qsort ===

(define (qsort lst)
	(if (empty? lst)
		null
		(let
			(
				(left (filter (lambda (x) (<= x (car lst))) (cdr lst)))
				(right (filter (lambda (x) (> x (car lst))) (cdr lst)))
			)
			(append (qsort left) (list (car lst)) (qsort right))
		)
	)
)

(display "=== qsort ===\n")
(qsort '(-4 10 -2 9 -10)) ;; '(-10 -4 -2 9 10)
(qsort '(3 4 -5 -9 18 6 7 11)) ;; '(-9 -5 3 4 6 7 11 18)
(qsort '(9 1 2 3 6 5 4)) ;; '(1 2 3 4 5 6 9)

;; === get-balance ===

(define (get-balance movements)
	(if (empty? movements)
		0
		(if (equal? (caar movements) "income")
			(+ (caddar movements) (get-balance (cdr movements)))
			(- (get-balance (cdr movements)) (caddar movements))
		)
	)
)

(display "=== get-balance ===\n")
(get-balance '(("income" "Salary" 4000) ("income" "Parents" 2000) ("expense" "Rent" 3500) ("expense" "food" 750) ("expense" "hobbies" 400) ("income" "Scholarship" 2500))) ;; 3850
(get-balance '(("income" "Salary" 20000) ("expense" "Rent" 5500) ("expense" "food" 4210) ("expense" "travel" 8000) ("expense" "taxes" 2500))) ;; -210

;; === toUpperTriangular ===

(define (toUpperTriangular matrix)
	(map (lambda (x) (map (lambda (y) (= y 1)) x)) matrix)
)

(display "=== toUpperTriangular ===\n")
(toUpperTriangular '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 16))) ;; '((1 2 3 4) (0 6 7 8) (0 0 11 12) (0 0 0 16))
(toUpperTriangular '((a b c) (d e f) (g h i))) ;; '((a b c) (0 e f) (0 0 i))

;; === dfs ===

(define (dfs tree)
	(if (empty? tree)
		null
		(if (list? tree)
			(append (dfs(car tree)) (dfs(cdr tree)))
			(list tree)
		)
	)
)

(display "=== dfs ===\n")
(dfs '()) ;; '()
(dfs '(10 (5 (16 (8) (9)) (12) (21)) (3 (6) (13 (2))))) ;; '(10 5 16 8 9 12 21 3 6 13 2)
(dfs '(8 (4 (5) (6 (13 (14) (15)))))) ;; '(8 4 5 6 13 14 15)
(dfs '(1 (2 (3 (4) (5) (6)) (7)))) ;; '(1 2 3 4 5 6 7)