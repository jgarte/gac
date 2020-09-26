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

(def (note->string note) -> string?
  ((pmatch note
           (integer? integer->lilynote)
           (symbol? scientificnote->lilynote)
           ;; could pass through strings, too
           (string? identity
                    ;; just delete the next
                    ;; form to enable them
                    (error "strings not OK for now")))
   note))

(define (note-display note port)
  (display-items port (list (note->string note)
                            "1" ;; XX for now
                            )))

(define (chord-display l port)
  (display "<" port)
  (display-items port
                 (list-join (map note->string l)
                            " "))
  (display ">1" port) ;; XX for now
  (newline port))

(define (lilyscore-display l port)
  (let ld ((l l))
    (pmatch l
      (pair?

       (define (process-rest)
         ;; Example: `(new: Staff (textLengthOn: (1 3 4)))` translated
         ;; to `\new Staff { \textLengthOn <c' cs' e'>1 }`. We have
         ;; already processed the first of l, `\new`; of the
         ;; remainder, the last one is a scope "{ }" or otherwise
         ;; something to recurse into; the values inbetween are
         ;; options, like `Staff`.
         (let* ((r (cdr l))
                (v (last r))
                (options (butlast r)))
           (for-each (lambda (option)
                       ;; simplified; for more see
                       ;; http://lilypond.org/doc/v2.18/Documentation
                       ;; /notation/creating-and-referencing-contexts
                       ;; #index-new-contexts
                       (pmatch option
                          (symbol?
                            ;; e.g. `Staff`
                           (display " " port)
                           (display (symbol->string option) port))))
                     options)
           (pmatch v

             (list?
              (display " {\n" port)
              (if (and (pair? v)
                       (integer? (first v)))
                  ;; v is a single chord
                  (ld v)
                  ;; v contains sublists (= chords)
                  (for-each (lambda (l)
                              (display " " port)
                              (ld l))
                            v))
              (display "}" port))
             
             (else
              (display " " port)
              (ld v))))

         (newline port))

       (let ((a (car l)))
              
         (pmatch a

           (keyword?
            (displayl port "\\" (keyword->string a))
            (process-rest))

           (symbol?
            (pmatch a

              (=symbol?
               (displayl port (=symbol->string a) " =")
               (process-rest))

              ('lexps
               (displayln "{" port)
               (for-each (lambda (chord)
                           (chord-display chord port))
                         (cdr l))
               (displayln "}" port))

              ('annotation
               ;; (lily '((1 4 5 6 7 4) (annotation below "hello")))
               (let-list ;;(([symbol? updown] [string? txt]) (cdr l))
                ((updown txt . chords) (cdr l))
                (-> symbol? updown)
                (-> string? txt)
                (unless (null? chords)
                  (lilyscore-display chords port))
                (display
                 (case updown
                   ((above up ^) "^")
                   ((below down _) "_")
                   (else
                    (error "annotation needs ^ or _ as first argument"
                           l)))
                 port)
                (write txt port)))
              
              (else
               ;; should be a note symbol => a single chord
               (chord-display l port))))

           (integer?
            ;; abspitch => a single chord
            (chord-display l port))

           (else
            ;; treat l as an actual list, not as an "AST" node
            (for-each ld l)))))

      (string?
       (write l port))

      (integer?
       (note-display l port)))))

(define (lilyscore->file l path)
  (call-with-output-file path
    (cut lilyscore-display l <>)))


(TEST
 > (def (tst v)
        (call-with-output-string ""
          (cut lilyscore-display v <>)))
 > (tst '(#:version "2.3.4"))
 "\\version \"2.3.4\"\n"
 > (tst '(#:header ((=tagline "foo") (=author "bar"))))
 "\\header {
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
              (10 44 23)) ;; ok bogus to have 2 scores, but for our test...
       (#:score
        ((#:new Staff
                ((C4 E4 G4)
                 (A3 F2) (annotation down "Foo")
                 (10 44 23)
                 (annotation up "Bar"
                             (11 44 23)
                             (10 44 23))))
         (#:layout ())
         (#:midi ())))))
 > (tst tval)
 "\\version \"2.17.2\"
\\glanguage \"english\"
\\header {
 tagline = \"foo\"
 author = \"bar\"
}
{
<c' e' g'>1
<a f,>1
<as' gs'''' b''>1
}
\\score {
 \\new Staff {
 <c' e' g'>1
 <a f,>1
 _\"Foo\" <as' gs'''' b''>1
 <b' gs'''' b''>1
<as' gs'''' b''>1
^\"Bar\"}
 \\layout {
}
 \\midi {
}
}
")
