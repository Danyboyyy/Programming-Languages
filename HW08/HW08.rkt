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

;; === maskedsum ===

(define (maskedSum lst mask)
  (if (empty? lst)
    0
    (if (not (false? (car mask)))
      (+ (car lst) (maskedSum (cdr lst) (cdr mask)))
      (maskedSum (cdr lst) (cdr mask))
    )
  )
)

(display "=== maskedsum ===\n")
(maskedSum '(1 2 3 4 5 6) '(#t #f #f #t #f #t)) ;; 11
(maskedSum '(1 2 3 4 5 6) '(#f #t #f #t #f #f)) ;; 6
(maskedSum '(1 2 3 4 5 6) '(#t #t #t #t #t #t)) ;; 21

;; === shift ===

(define (shift lst n)
  (if (= n 0)
    lst
    (if (> n 0)
      (append '(0) (shift lst (- n 1)))
      (append (shift lst (+ n 1)) '(0))
    ) 
  )
)

(display "=== shift ===\n")
(shift '(3 5 0 0 2) 3) ;; '(0 0 0 3 5 0 0 2)
(shift '(19 4 50 10 2) -2) ;; '(19 4 50 10 2 0 0)

;; === list2matrix ===

(define (list2matrix lst r c)
  (if (null? lst)
    '()
    (if (= (* r c) (length lst))
      (cons (take lst c) (list2matrix (drop lst c) (- r 1) c))
      lst
    )
  )
)

(display "=== list2matrix ===\n")

(list2matrix '(10 20 30 40 50 60) 2 3) ;; '((10 20 30) (40 50 60))
(list2matrix '(10 20 30 40 50 60) 3 2) ;; '((10 20) (30 40) (50 60))
(list2matrix '(10 20 30 40 50 60) 3 3) ;; '(10 20 30 40 50 60)

;; === myFilter ===

(define (myFilter f x)
  (if (empty? x)
    null
    (if (not (false? (f (car x))))
      (cons (car x) (myFilter f (cdr x)))
      (myFilter f (cdr x))
    )
  )
)

(display "=== myFilter ===\n")
(myFilter (lambda (x) (> x 2)) '(1 2 0 3 4 1 2 9)) ;; '(3 4 9)
(myFilter (lambda (x) (= x 2)) '(1 2 0 3 4 1 2 9)) ;; '(2 2)
(myFilter (lambda (x) (= (remainder x 2) 0)) '(1 2 0 3 4 1 2 9)) ;; '(2 0 4 2)

;; === swap ===

(define (swap2 i j vali valj lst)
  (if (empty? lst)
    null
    (if (= i 0)
      (cons valj (swap2 (- i 1) (- j 1) vali valj (cdr lst)))
      (if (= j 0)
        (cons vali (swap2 (- i 1) (- j 1) vali valj (cdr lst)))
        (cons (car lst) (swap2 (- i 1) (- j 1) vali valj (cdr lst)))
      )
    )
  )
)

(define (swap i j lst)
  (swap2 i j (list-ref lst i) (list-ref lst j) lst)  
)

(display "=== swap ===\n")
(swap 4 5 '(a b c d e f)) ;; '(a b c d f e)
(swap 1 3 '(10 20 30 40)) ;; '(10 40 30 20)
(swap 0 4 '(a b c d (e) f)) ;; '((e) b c d a f)

;; === evaluate ===

(define (evaluate coef x)
  (foldl + 0 (map * coef (map expt (build-list (length coef) (lambda (_) x)) (reverse (build-list (length coef) values)))))
)

(display "=== evaluate ===\n")
(evaluate '() 100) ;; 0
(evaluate '(2 3.1 10 0) 2) ;; 48.4
(evaluate '(10 0) 2) ;; 20
(evaluate '(1 2 3 4 5) 3) ;; 179

;; === ackermann ===

(define (ackermann m n)
  (if (= n 0)
    (ackermann (- m 1) 1)
    (if (= m 0)
      (+ 1 n)
      (ackermann (- m 1) (ackermann m (- n 1)))
    )
  )
)

(display "=== ackermann ===\n")
(ackermann 2 2) ;; 7
(ackermann 2 5) ;; 13
(ackermann 3 1) ;; 13
(ackermann 3 8) ;; 2045

;; === select ===

;; This should not be done! (but it helps)
(define table '(
  ((name "Charles") (age 24))
  ((age 23) (name "Mary") (lastName "Danvers") (gender "female"))
  ((name "Caroline") (lastName "Ortiz") (age 19))
  )
)

(define (sel table key)
  (if (null? table)
    null
    (append (map cadr (filter (lambda (x) (equal? (car x) key)) (car table))) (sel (cdr table) key))
  )
)

(define (select table key)
  (cons key (sel table key))
)

(display "=== select ===\n")
(select table 'age) ;; '(age 24 23 19)
(select table 'phone) ;; '(phone)
(select table 'lastName) ;; '(lastName "Danvers" "Ortiz")