#lang racket

(define (sum l)
  (if (empty? l)
      0
      (if (number? (car l))
          (+ (car l) (sum(cdr l)))
          (sum (cdr l))
      )
  )
)

(define (palindrome l)
  (equal? l (reverse l))
)

(define (rev l)
  (if (empty? l)
      '()
      (append (rev (cdr l)) (list (car l)))
  )
)

(define (get l i)
  (if (and (>= i 0) (< i (length l)))
      (if (= i 0)
          (car l)
          (get (cdr l) (- i 1))
      )
      null
  )
)

(define (extractOdd l)
  (extractOddAux l #f)
)

(define (extractOddAux l aux)
  (if (empty? l)
      null
      (if aux
          (cons (car l) (extractOddAux (cdr l) (not aux)))
          (extractOddAux (cdr l) (not aux))
      )
  )
)