(define (displayl port . l-of-str)
  (for-each (lambda (str)
	      (display str port))
	    l-of-str))

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


(define (keyword->string k)
  (symbol->string (keyword->symbol k)))

(define (=symbol? a)
  (let* ((s (symbol->string a))
         (l (string-length s)))
    (and (>= l 2)
         (eq? (string-ref s 0) #\=))))

(define (=symbol->string a)
  (let* ((s (symbol->string a))
         (l (string-length s)))
    (and (>= l 2)
         (substring s 1 l))))


(define (display-chord l port)
  (diplayl port
           "<"
           (map note->string l)
           ">"))

(define (lily->file l path)
  (call-with-output-file path
    (lambda (port)
      (let lf ((l l)
	       (is-header? #f))
	(xcond ((pair? l)
		(let ((a (car l))
                      (process-rest
                       (lambda ()
                         (let* ((v (xone (cdr l))))
                           (cond ((pair? v)
                                  (display " = {\n" port)
                                  (for-each (lambda (l)
                                              (display " " port)
                                              (lf l #t))
                                            v)
                                  (display "}" port))
                                 (else
                                  (display " " port)
                                  (lf v #t))))
                         (newline port))))
                  (cond ((_keyword? a)
                         (displayl port "\\" (keyword->string a)) 
                         (process-rest))
                        ((symbol? a)
                         (if is-header?
                             (begin
                               (assert (=symbol? a))
                               (displayl port (=symbol->string a) " =")
                               (process-rest))
                             (display-chord l port)))
                        (else
                         ;; treat l as an actual list, not as an "AST" node
                         (for-each (lambda (v)
                                     (lf v is-header?))
                                   l)))))
	       ((string? l)
		(write l port)))))))

(define h
  `((#:version "2.17.2")
    (#:glanguage "english")
    (#:header ((=tagline "foo")
               (=author "bar")))
    (c4 e4 g4)))

(define (t1)
  (lily->file '(#:version "2.3.4") "t1"))

(define (t2)
  (lily->file '(#:header ((=tagline "foo") (=author "bar"))) "t2"))

(define (t)
  (lily->file h "foo.ly"))

