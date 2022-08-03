#lang racket

;; macros.rkt

;;
;; An example of a BAD assert: always prints #f if it expr is false.
;;
;; > (assert-bad (= 1 2))
;; assert: assertion fail: #f
(define (assert-bad expr)
    (when (not expr)
        (error 'assert "assertion fail: ~s" expr)))

;;
;; Another BAD assert: programmer must give two copies of the expression.
;;
;; > (assert-also-bad (= 1 2) '(= 1 2))
;; assert: assertion fail: (= 1 2)
;;
(define (assert-also-bad expr quoted-expr)
    (when (not expr)
        (error 'assert "assertion fail: ~s" quoted-expr)))

;;
;; A GOOD assert: single expression passed in, useful output printed.
;;
;; > (assert (= 1 2))
;; assert: assertion failed: (= 1 2)
(define-syntax-rule (assert expr)
  (when (not expr)
    (error 'assert "assertion failed: ~s" (quote expr))))


;;
;; (print-val expr) prints expr unevaluated and evaluated. It is useful
;; for debugging:
;;
;; > (print-val (+ 1 2))
;; (+ 1 2) ==> 3
;;
;; > (print-val (cons 'a '(1 2 3)))
;; (cons 'a '(1 2 3)) ==> (a 1 2 3)
;;
;; > (define x 14)
;; > (print-eval x)
;; x ==> 14
;;
;; > (print-eval even?)
;; even? ==> #<procedure:even?>
;;
(define-syntax-rule (print-val expr)
  (printf "~a ==> ~a" (quote expr) expr))

;;
;; BAD implementation of short-circuited or: e1 gets evaluated twice.
;;
(define-syntax-rule (my-or-bad e1 e2)
  (if e1 e1 e2))

;;
;; GOOD implementation of the short-circuited or using a macro.
;; e2 is only evaluated when e1 is #t.
;;
;; This is an important example that works correctly in Racket,
;; but if you use straightforward macro expansion it seems like it
;; should not work:
;;
;;  > (define x 5)       ;; global x
;;  > (my-or #f (= x 5))
;;  #t
;;
(define-syntax-rule (my-or e1 e2)
  (let ([x e1])
    (if x x e2)))

(define (true)
  (println "true")
  #t)

(define (false)
  (println "false")
  #f)
