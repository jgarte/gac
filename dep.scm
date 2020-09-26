(defclass (foo [list? l1]
               [(list-of-length (length l1)) l2]))

(defclass (foo2 [(list-of real?) l1]
                [(list-of symbol?) l2])
  (defmethod (bla x) ...))

(def. (foo2.bla x) ...)


(def (f) -> foo2?
     (foo2 '(1 3 4 5) '(a b c)))

(def (g [foo? f]) -> (list-of real?)
     (foo.l1 f))

(first (g (foo2 '(1 2 34) '(a b c)))) -> real? or exception


