#lang racket

(define scale 4.5)
(define title "Dr Racket")
(define fruit '(apple orange pear))


(define (inc n)
  (+ n 1))

;; 1 + 2 + 3 + ... + n = n(n+1)/2
(define (sum n)
  (/ (* n (+ n 1)) 2))

(define (mymax x y)
  (if (< x y)
      y
      x))

(define (sign n)
  (cond ((< n 0) -1)
        ((= n 0)  0)
        (#t       1)))

(define times2
  (lambda (n) (* 2 n)))

;;(define (twice f x)
;;  (f (f x)))

(define (twice f)
  (lambda (x)
    (f (f x))))

(define g (twice sqr))


  

  