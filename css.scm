

(def (mycss)
     (css
      (class 'foo
             margin: (* (px 21) 2))))


(def (fact n)
     (warn "fact" n)
     (if (zero? n) 1
         (* n (fact (dec n)))))

'(defmacro (FACT ))

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
  (def v (quote ,expr))
  (warn "v=" v)
  `(list ,v `(list "The result is " ,,expr)))
