;; primes.rkt

#lang racket

;;
;; A **prime number** is a positive integer n that has 
;; exactly two different divisors, 1 and n. For example, 
;; 2, 3, 5, 7, and 101 are all primes, while 4, 6, 9, 15, 
;; and 100 are not.
;;
;; One way to test if a number n is prime is to use 
;; **trial division**. You do this by generating the numbers
;; 2, 3, 4, ..., sqrt(n), and checking if any of them evenly
;; divide into n. If any do, then n is *not* prime. But if
;; none divide into n, then n must be prime.
;;
;; We only need to try divisors up to (and including) the
;; square root of n since divisors usually come in pairs, e.g
;; 1*12=12, 2*6=12, and 3*4=13, and so we only need to check
;; 1, 2, and 3 ad divisors. Perfect squares, like 100, do
;; have a pair of identical divisors, i.e. 10*10=100. That's
;; why we check to divisors up to and *including* the the
;; square root of the number.
;;


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
;; (range 2 n) returns the list '(2 3 4 ... (- n 1)).
;;
(define (num-primes-less-than n)
  (length (filter is-prime1? (range 2 n))))
;;
;; > (time (num-primes-less-than 10000))
;; cpu time: 47 real time: 40 gc time: 31
;; 1229
