#lang racket

#;(define (count-symbols lst)
    (cond [(empty? lst)
           0]
          [(symbol? (first lst))
           (+ 1 (count-symbols (rest lst)))]
          [else
           (count-symbols (rest lst))]))  ;; tail-recursive

#;(define (my-filter pred? lst)
    (cond [(empty? lst)
           '()]
          [(pred? (first lst))
           (cons (first lst)
                 (my-filter pred? (rest lst)))]
          [else
           (my-filter pred? (rest lst))]))

#;(define (count-symbols lst)
    (length (my-filter symbol? lst)))

#;(define (my-count pred? lst)
    (length (my-filter pred? lst)))

#;(define (count-symbols lst)
    (my-count symbol? lst))

#;(define (deep-count-symbols lst)
    (count-symbols (flatten lst)))

#;(define (deep-count pred? lst)
    (my-count pred? (flatten lst)))


#;(define (parity x)
    (cond [(not (integer? x))
           'not-an-int]
          [(even? x)
           'even]
          [else
           'odd]))

#;(define (divisors n)
    (filter (lambda (x) (= 0 (remainder n x)))
            (range 1 (+ n 1))))
         
#;(define (is-prime? n)
    (cond [(< n 2) #f]
          [(= n 2) #t]
          [(= 0 (remainder n 2))
           #f]
          [else
           (= 2 (length (divisors n)))]))

#;(define (sum lst)
    (if (empty? lst)
        0
        (+ (first lst) (sum (rest lst)))))

#;(define (prod lst)
    (if (empty? lst)
        1
        (* (first lst) (prod (rest lst)))))

#;(define (my-length lst)
    (if (empty? lst)
        0
        (+ 1 (length (rest lst)))))

#;(define (fold-right f init lst)
    (if (empty? lst)
        init
        (f (first lst) (fold-right f init (rest lst)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Review of some ways to write a summation function.
;;
(define (sum1 lst)
  (if (empty? lst)
      0
      (+ (first lst) (sum1 (rest lst)))))

;;
;; (fold-right f init '(a b c)) calculates this:
;;
;;    (f a (f b (f c init)))
;;
(define (fold-right f init lst)
  (if (empty? lst)
      init
      (f (first lst) (fold-right f init (rest lst)))))

(define (sum2 lst)
  (fold-right + 0 lst))

(define (sum3 lst)
  (apply + lst))

(define (factorial n)
  (apply * (range 1 (+ n 1))))











#;(define (my-flatten lst)
    (cond [(empty? lst)
           '()]
          [(list? (first lst))
           (append (my-flatten (first lst))
                   (my-flatten (rest lst)))]
          [else
           (cons (first lst) (my-flatten (rest lst)))]))


(define (deep-count-numbers lst)
  (length (filter number? (flatten lst))))


;; an alternate implementation of flatten ...
(define (my-flatten lst)
  (apply append
         (map (lambda (item)
                (if (list? item)
                    (my-flatten item)
                    (list item)))
              lst
              )))


  



;; composing functions


(define (comp f g)
  (lambda (x)
    (f (g x))))

(define my-second (comp first rest))

#;(define (my-second x)
    (first (rest x)))


(define my-third (compose first rest rest))


;; flipping functions


;; I, M, and K
