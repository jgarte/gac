
(require)

(define keyword? (either ##keyword? uninterned-symbol?))

(define (keyword->symbol k)
  (string->symbol (xcond ((##keyword? k) (##keyword->string k))
                         ((uninterned-symbol? k) (symbol->string k)))))

