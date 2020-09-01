

(def (mycss)
     (css
      (class 'foo
             margin: (* (px 21) 2))))


(def (fact n)
     (if (zero? n) 1
         (* n (fact (dec n)))))


(def f
     (lambda (m) (+ (fact 10) m)))


;; (let ..binds.. ..expr..)

(defmacro (the expr _where binds)
  (if (eq? (source-code _where) where:)
      `(let ,binds ,expr)
      (raise-source-error _where "invalid keyword")))

(def f*
     (the (lambda (m) (+ f10 m))
          where:
          (f10 (fact 10))))

