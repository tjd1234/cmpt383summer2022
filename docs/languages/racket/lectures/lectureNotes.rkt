#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Warm-up
;;
;; What do these expressions evaluate to?
;;
;; 1. (list list)
;; 2. (list 'list)
;; 3. (list first '(rest))
;; 4. (list and or)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; composing functions
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (comp f g)
  (lambda (x)
    (f (g x))))

#;(define (chain args)
  (apply compose (reverse args)))

(define my-second (comp first rest))

#;(define (my-second x)
    (first (rest x)))

;;
;; Racket's built-in compose functions lets you compose 2 or more
;; functions.
;;
(define my-third (compose first rest rest))

;;
;; flipping functions
;;
(define (flip f)
  (lambda (x y)
    (f y x)))

(define fcons (flip cons))

(define chain (flip comp))

;;
;; curried functions
;;
(define c+ (curry +))
(define (add x y) (+ x y))
(define cadd (curry add))
(define inc (cadd 1))

(define c-cons (curry cons))
(define cherry (c-cons 'cherry))


;; doubles every number in lst
(define (double-all1 lst)
  (map (lambda (x) (* 2 x)) lst))

(define c* (curry *))
(define c-map (curry map))

;; No mention of lst!
(define double-all2 (c-map (c* 2)))

;; assumes f takes 2 inputs
(define (my-curry f)
  (lambda (a)
    (lambda (b)
      (f a b))))


;; I, M, and K

(define (I x) x)

(define (M x) (x x))

#;((lambda (x) (x x))
 (lambda (x) (x x)))

;; Y gives your recursion
(define Y 
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (x) (f (lambda (y) ((x x) y)))))))

(define factorial-helper
  (lambda (f)
    (lambda (n)
      (if (= n 0)
          1
          (* n (f (- n 1)))))))

(define factorial (Y factorial-helper))

(define fibonacci-helper
  (lambda (f)
    (lambda (n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (f (- n 1)) (f (- n 2))))))))

(define fibonacci (Y fibonacci-helper))


;; K makes constant functions
(define (K x) (lambda (y) x))
(define just-cow (K 'cow))


;; S3 is a generalization of function application. Instead giving you (x y),
;; it gives you ((x z) (y z)).
(define (S3 x y z)
  ((x z) (y z)))

;; S is a curried version of S3. You can pass 1 or 2 arguments, and it returns a
;; function ready to accept the remaining arguments.
(define S (curry S3))


;; I can be written in terms of S and K
(define (I2 x) ((S K K) x))

(define (I3 x) ((S K S) x))

;; M can be written in terms of S and K
(define (M2 x) (S I I x))

;; Fact: any pure function can written in terms of S and K.




