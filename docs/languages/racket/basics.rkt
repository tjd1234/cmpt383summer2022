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
  (cond [(< n 0) -1]
        [(= n 0)  0]
        [else     1]))

(define times2
  (lambda (n) (* 2 n)))

;;(define (twice f x)
;;  (f (f x)))

(define (twice f)
  (lambda (x)
    (f (f x))))

(define g (twice sqr))

(define (h x y)
  (let* ([a (* x x)]
         [b (* y y)]
         )
    (+ a b)
    )
  )

(define (my-second lst)
  (first (rest lst)))

(define (my-length lst)
  (if (empty? lst)
      0
      (+ 1 (my-length (rest lst)))))

(define (count-sym lst)
  (if (empty? lst)
      0
      (+ (if (symbol? (first lst)) 1 0)
         (count-sym (rest lst)))))

(define (count-num lst)
  (if (empty? lst)
      0
      (+ (if (number? (first lst)) 1 0)
         (count-num(rest lst)))))

(define (count lst pred?)
  (if (empty? lst)
      0
      (+ (if (pred? (first lst)) 1 0)
         (count (rest lst) pred?))))

