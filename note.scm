(require)

(export scientificnote->integer
        ;; integer->scientificnote
        integer->lilynote
        ;; lilynote->integer
        scientificnote->lilynote
        )

;; representation 1: integers

;; This could also be called AbsPitch, as in
;; https://github.com/Euterpea/EuterpeaLite/blob/master/EuterpeaLite/Music.lhs



;; representation 2: scientificnote (symbols)  c4
;; https://en.wikipedia.org/wiki/Scientific_pitch_notation

'(define (integer->scientificnote i)
  )

(define (scientificnote-parse-base str)
  (if (string-empty? str)
      0
      (let ((n (string->number str)))
        (if (and n
                 (integer? n)
                 (>= n 0))
            n
            (error "invalid scientific note base:" str)))))


(define scientificnote-subs
  '(C CS D DS E F FS G GS A AS B))

(define lilynote-subs-vector
  (list->vector (map (lambda (sym)
                       (string-lc (symbol->string sym)))
                     scientificnote-subs)))

(define scientificnote-sub-alis
  (map cons
       scientificnote-subs
       (iota 12)))

(define (scientificnote-parse-sub ch)
  (cond ((assq (string->symbol ch) scientificnote-sub-alis)
         => cdr)
        (else
         (error "invalid scientificnote sub:" ch))))

(define (scientificnote->integer sym)
  (let* ((s (symbol->string sym))
         (len (string-length s)))
    (if (>= len 1)
        (let lp ((i 0))
          (if (< i len)
              (let ((c (string-ref s i)))
                (if (char-digit? c)
                    (+ (scientificnote-parse-sub (substring s 0 i))
                       (* 12
                          (scientificnote-parse-base (substring s i len)))
                       -48)
                    (lp (inc i))))
              (+ (scientificnote-parse-sub (substring s 0 i)) (* 12 4) -48)
              ;; or:
              ;; (error "scientificnote without octave not accepted for not"
              ;;        sym)
              ))
        (error "invalid scientificnote:" sym))))


(TEST
 > (scientificnote->integer 'C3)
 -12
 > (scientificnote->integer 'C4)
 0
 > (scientificnote->integer 'C5)
 12
 > (scientificnote->integer 'C3)
 -12
 > (scientificnote->integer 'CS3)
 -11)


;; representation 3: lily note string

(define (integer->quotient+remainder i d)
  (values (quotient i d)
          (remainder i d)))

(define (quotient+remainer->integer q r d)
  (+ (* q d) r))

(define (flub i d)
  "the whole part of the division of i by d, but in a way that it fits
modulo--?"
  (if (negative? i)
      (dec (quotient i d))
      (quotient i d)))

(TEST
 > (flub 10 12)
 0
 > (flub 11 12)
 0
 > (flub 12 12)
 1
 > (flub 0 12)
 0
 > (flub -1 12)
 -1
 > (flub -10 12)
 -1
 > (flub -11 12)
 -1
 > (flub -12 12)
 -2)


(define (integer->flub+modulo i d)
  (values (flub i d)
          (modulo i d)))

(define (flub+modulo->integer q r d)
  (+ (* q d) r))


(define (lilynote-base-format i)
  (cond ((= i 4) "")
        ((< i 4) (make-string (- 4 i) #\,))
        (else (make-string (- i 4) #\'))))


(define (integer->lilynote i)
  (string-append
   (vector-ref lilynote-subs-vector (modulo i 12))
   (let ((f (flub i 12)))
     (if (or (= i -1) (= i -12)) ;; ridiculous
         ""
         (lilynote-base-format (+ 5 f))))))


(TEST
 > (integer->lilynote 1)
 "cs'"
 > (integer->lilynote 0)
 "c'"
 > (integer->lilynote -1)
 "b"
 > (integer->lilynote -2)
 "as"
 > (integer->lilynote -12)
 "c"
 > (integer->lilynote -13)
 "b,"
 > (map integer->lilynote (iota 16 -37))
 ("b,,,"
  "c,,"
  "cs,,"
  "d,,"
  "ds,,"
  "e,,"
  "f,,"
  "fs,,"
  "g,,"
  "gs,,"
  "a,,"
  "as,,"
  "b,,"
  "c,"
  "cs,"
  "d,")
 > (map integer->lilynote (iota 20 -3))
 ("a"
  "as"
  "b"
  "c'"
  "cs'"
  "d'"
  "ds'"
  "e'"
  "f'"
  "fs'"
  "g'"
  "gs'"
  "a'"
  "as'"
  "b'"
  "c''"
  "cs''"
  "d''"
  "ds''"
  "e''"))


;; (define (lilynote->integer str)
;;   )


(define scientificnote->lilynote
  (=>* scientificnote->integer integer->lilynote))

(TEST
 > (scientificnote->lilynote 'C3)
 "c"
 > (scientificnote->lilynote 'C4)
 "c'")

