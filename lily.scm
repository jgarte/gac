(require note)

(export lilyscore->file
        #!optional
        chord-display
        lilyscore-display)


(define (display-items port l-of-str)
  (for-each (lambda (str)
	      (display str port))
	    l-of-str))

(define (displayl port . l-of-str)
  (display-items port l-of-str))


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


(define (chord-display l port)
  (display "<" port)
  (display-items port
                 (list-join (map (lambda (note)
                                   (xcond ((integer? note)
                                           (integer->lilynote note))
                                          ((symbol? note)
                                           (scientificnote->lilynote note))
                                          ;; could pass through strings, too
                                          ))
                                 l)
                            " "))
  (display ">1" port) ;; XX for now
  )

(define (lilyscore-display l port)
  (let lf ((l l)
           (is-header? #f))
    (xcond ((pair? l)
            (let ((a (car l))
                  (process-rest
                   (lambda ()
                     (let* ((v (xone (cdr l))))
                       (cond ((pair? v)
                              (display " {\n" port)
                              (for-each (lambda (l)
                                          (display " " port)
                                          (lf l #t))
                                        v)
                              (display "}" port))
                             (else
                              (display " " port)
                              (lf v #t))))
                     (newline port))))
              (cond ((keyword? a)
                     (displayl port "\\" (keyword->string a))
                     (display " =" port)
                     (process-rest))
                    ((symbol? a)
                     (if is-header?
                         (begin
                           (assert (=symbol? a))
                           (displayl port (=symbol->string a) " =")
                           (process-rest))
                         (begin
                           (assert (eq? a 'lexps))
                           (displayln "{" port)
                           (for-each (lambda (chord)
                                       (chord-display chord port)
                                       (newline port))
                                     (cdr l))
                           (displayln "}" port))))
                    (else
                     ;; treat l as an actual list, not as an "AST" node
                     (for-each (lambda (v)
                                 (lf v is-header?))
                               l)))))
           ((string? l)
            (write l port)))))

(define (lilyscore->file l path)
  (call-with-output-file path
    (cut lilyscore-display l <>)))


(TEST
 > (def (tst v)
        (call-with-output-string ""
          (cut lilyscore-display v <>)))
 > (tst '(#:version "2.3.4"))
 "\\version = \"2.3.4\"\n"
 > (tst '(#:header ((=tagline "foo") (=author "bar"))))
 "\\header = {
 tagline = \"foo\"
 author = \"bar\"
}\n")


(TEST
 > (define tval
     ;; "lilyscore"
     `((#:version "2.17.2")
       (#:glanguage "english")
       (#:header ((=tagline "foo")
                  (=author "bar")))
       (lexps (C4 E4 G4)
              (A3 F2)
              (10 44 23))))
 > (tst tval)
 "\\version = \"2.17.2\"
\\glanguage = \"english\"
\\header = {
 tagline = \"foo\"
 author = \"bar\"
}
{
<c' e' g'>1
<a f,>1
<as' gs'''' b''>1
}
"
 )

