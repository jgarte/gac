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

(define (lily->file l path)
  (call-with-output-file path
    (lambda (port)
      (let lf ((l l)
	       (is-header? #f))
	(xcond ((pair? l)
		(let ((a (car l)))
		 (xcond ((keyword? a)
			 (displayl port "\\" (keyword->string a)) 
			 (for-each (lambda (l)
				     (display " " port)
				     (lf l #t))   
				   (cdr l))
			 (newline port)))))
	       ((string? l)
		(write l port)))))))

(define h
`(
 (#:version "2.17.2")
 (#:glanguage "english")
 (#:header ((=tagline "foo")
	    (=author "bar")))
 (c4 e4 g4)))

(define (t1)
  (lily->file '(#:version "2.3.4") "t1"))

(define (t2)
  (lily->file '(#:header (=tagline "foo") (=author "bar")) "t2"))

(define (t)
  (lily->file t "foo.ly"))

