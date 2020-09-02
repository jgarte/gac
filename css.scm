

(def (mycss)
     (css
      (class 'foo
             margin: (* (px 21) 2))))


(def (fact n)
     (warn "fact" n)
     (if (zero? n) 1
         (* n (fact (dec n)))))

(defmacro (FACT n)
  (assert* natural0? n
           (lambda (n)
             XXX)))

(def f
     (lambda (m) (+ (FACT 10) m)))


;; (let ..binds.. ..expr..)

(defmacro (the expr _where binds)
  (if (eq? (source-code _where) where:)
      `(let ,binds ,expr)
      (raise-source-error _where "invalid keyword")))

'(def f*
     (the (lambda (m) (+ f10 m))
          where:
          (f10 (fact 10))))

'(define-syntax kwote
  (syntax-rules ()
    ((kwote exp)
     (quote exp))))
'(kwote (foo . bar))

(defmacro (kwote exp)
  (warn "kwote" exp)
  `(quote ,exp))

;; (equal? (foo (+ 10 20))
;;         '((+ 10 20) 30))

(defmacro (foo expr)
  (def v `(quote ,expr))
  (warn "v=" (cj-desourcify v))
  `(list ,v `(list "The result is " ,,expr)))

(def (t)
     (foo (+ (error "nope" 10) 20)))

'(defmacro (m+ [number? a] [number? b])
   `(+ ,a ,b))
;; *** ERROR IN #<procedure #20>, "/home/chris/gac/css.scm"@53.1 -- a does not match number?: (source* 1 "css.scm" 57 10)

(defmacro (m+ a b)
  (assert* number? a)
  (assert* number? b)
  `(+ ,a ,b))

'(def (t2)
     (m+ 1 "hello"))

'() ;; what did we want ?


