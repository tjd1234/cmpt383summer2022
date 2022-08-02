#lang racket

;;
;; The following are functions for processing propositional boolean expressions
;; such as (t and ((not t) or f)). In most of the functions t (true) and f (false)
;; are the only literal terms.
;;
;; The language of propositional boolean expressions can be defined more formally
;; in EBNF (extended Backaus-Naur form) like this:
;;
;;          expr =  bool-literal | not-expr 
;;                | and-expr     | or-expr
;;
;;  bool-literal = "t" | "f"
;;
;;      not-expr = "(" "not" expr ")"
;;
;;      and-expr = "(" expr "and" expr ")"
;;
;;       or-expr = "(" expr "or" expr ")"
;;
;;

;;
;; Checks for propositional boolean expressions of these forms:
;;
;;   t, f         boolean literals
;;   (not e)      e is a propositional boolean expression
;;   (e1 and e2)  e1, e2 are propositional boolean expression
;;   (e1 or e2)   e1, e2 are propositional boolean expression 
;;
(define (is-expr? e)
  (match e
    ['t           #t]
    ['f           #t]
    [`(not ,a)    (is-expr? a)]
    [`(,a or ,b)  (and (is-expr? a)
                       (is-expr? b))]
    [`(,a and ,b) (and (is-expr? a)
                       (is-expr? b))]
    [_            #f]
    ))

;;
;; Evaluates the given propositional boolean expression,
;; returning #t or #f.
;;
(define (eval-prop-bool expr)
  (match expr
    ['t           #t]
    ['f           #f]
    [`(not ,a)    (not (eval-prop-bool a))]
    [`(,a or ,b)  (or (eval-prop-bool a)
                      (eval-prop-bool b))]
    [`(,a and ,b) (and (eval-prop-bool a)
                       (eval-prop-bool b))]
    [_ (error "eval-prop-bool: syntax error")]
    ))


;;
;; A nand-only expression is a propositional boolean expression
;; whose only logical operator is nand.
;;
;; (a nand b) is true when a and b are both true, and false otherwise.
;;
(define (is-nand? expr)
  (match expr
    ['t            #t]
    ['f            #t]
    [`(,a nand ,b) (and (is-nand? a)
                        (is-nand? b))]
    [_             #f]
    ))


;;
;; Returns the value of expr, given that its a nand-only expression.
;;
(define (eval-nand expr)
  (match expr
    ['t            #t]
    ['f            #f]
    [`(,a nand ,b) (not (and (eval-nand a)
                             (eval-nand b)))]
    [_ (error "eval-nand: syntax error")]
    ))

;;
;; Converts a propositional expression into a logically equivalent one that uses only
;; nand. Any symbol can be used in an expression, e.g.:
;;
;;   > (to-nand '(not (p or q)))
;;   '(((p nand p) nand (q nand q)) nand ((p nand p) nand (q nand q)))
;;
;; Nand rules:
;;
;;   (not p)   <==> (p nand p)
;;   (p and q) <==> ((p nand q) nand (p nand q))
;;   (p or q)  <==> ((p nand p) nand (q nand q))
;;
(define (make-nand a b) (list a 'nand b))

(define (to-nand expr)
  (if (symbol? expr) expr
      (match expr
        [`(not ,a)    (let ([na (to-nand a)])
                        (make-nand na na))]
        [`(,a or ,b)  (let* ([na (to-nand a)]
                             [nb (to-nand b)]
                             [nana (make-nand na na)]
                             [nbnb (make-nand nb nb)])
                        (make-nand nana nbnb))]     
        [`(,a and ,b) (let* ([na (to-nand a)]
                             [nb (to-nand b)]
                             [nanb (make-nand na nb)])
                        (make-nand nanb nanb))]
        [_ (error "nand-rewrite syntax error")]
        )))

;;
;; We can now evaluate a propositional boolean expression by converting to
;; nand-only and then calling eval-nand.
;;
(define (eval-prop-bool2 e)
  (eval-nand (to-nand e)))

;;
;; Simplifying a propositional expression by re-writing expressions of the form
;; (not (not a)) to a.
;;
;; double negation elimination
;; (not (not expr)) <==> expr
(define (simplify expr)
  (match expr
    ['t              't]
    ['f              'f]
    [`(not (not ,a)) (simplify a)]
    [`(not ,a)       (list 'not (simplify a))]
    [`(,a or ,b)     (list (simplify a) 'or (simplify b)) ]
    [`(,a and ,b)    (list (simplify a) 'and (simplify b))]
    [_ (error "simplify: syntax error")]
    ))

;;
;; Convert expressions of this form:
;;
;;    (cond (test val1)
;;          (else val2))
;;
;; to this:
;;
;;    (if test val1 val2)
;;
(define (rewrite-simple-cond expr)
  (if (not (list? expr)) expr
      (match expr
        [`(cond (,test ,val1)
                (else ,val2)) (map rewrite-simple-cond 
                                   (list 'if test val1 val2))]
        [`(cond (,test ,val1)
                (#t ,val2))   (map rewrite-simple-cond 
                                   (list 'if test val1 val2))]
        [_ (map rewrite-simple-cond expr)])))

(define test-fn1
  '(define (sum lst)
     (cond [(empty? lst) 0]
           [else (sum (rest lst))])))

;;
;; This shows a case where we *don't* want a simple cond convert to an if-statement.
;; The simple conds inside the match must remain as simple conds.
;;
(define test-fn2
  '(define (rewrite-simple-cond expr)
     (cond [(not (list? expr)) expr]
           [else (match expr
                   [`(cond (,test ,val1)
                           (else ,val2)) (map rewrite-simple-cond 
                                              (list 'if test val1 val2))]
                   [`(cond (,test ,val1)
                           (#t ,val2))   (map rewrite-simple-cond 
                                              (list 'if test val1 val2))]
                   [_ (map rewrite-simple-cond expr)])])))

