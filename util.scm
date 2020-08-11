;; (xcond a
;;        b
;;        c)

;; (cond a
;;       b
;;       c
;;       (else (error "no match")))


(define-syntax xcond
  (syntax-rules ()
    ((xcond args ...)
     (cond args ... (else (error "no match"))))))


