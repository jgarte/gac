
(define keyword? (either ##keyword? uninterned-symbol?))

(define (keyword->symbol k)
  (string->symbol (xcond ((##keyword? k) (keyword->string))
                         ((uninterned-symbol? k) (symbol->string k)))))

