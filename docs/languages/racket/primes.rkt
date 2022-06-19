;; primes.rkt

#lang racket

;;
;; Returns a list of all the divisors of n.
;;
;; Works by keeping all the numbers on the list
;; (1 2 ... (sqrt n)) that divide evenly into n.
;;
(define (half-divisors n)
  (filter (lambda (d) (= 0 (remainder n d)))
          (range 1 (+ 1 (round (sqrt n))))))

;;
;; Returns true when n is prime, and false otherwise.
;;
;; Not as efficent as it could be. You don't need all
;; divisors of n, just the smallest one between 1 and n.
;;
(define (is-prime1? n)
  (cond [(< n 2) #f]
        [(= n 2) #t]
        [(= 0 (remainder n 2)) #f]
        [else (= 1 (length (half-divisors n)))]))

;;
;; Returns true when n is prime, and false otherwise.
;;
;; Simpler implementation than the previous version, but not as
;; efficient.
;;
(define (is-prime2? n)
  (= 1 (length (half-divisors n))))

;;
;; Returns the number of primes less than n.
;;
(define (num-primes-less-than n)
  (length (filter is-prime1? (range 2 n))))
;;
;; > (time (num-primes-less-than 10000))
;; cpu time: 47 real time: 40 gc time: 31
;; 1229
