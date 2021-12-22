#lang racket

(define (sublistL3 x y lst)
  (if (empty? lst)
    lst
    (if (= (car lst) y)
      (list y)
      (if (or (null? x) (= (car lst) x)) 
        (cons (car lst) (sublistL3 '() y (cdr lst)))
        (sublistL3 x y (cdr lst))
      )
    )
  )
)

(display (sublistL3 4 2 '(8 6 4 3 1 2 9))) ; '(4 3 1 2)