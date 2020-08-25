(require sg1)

'(define-module (gac pc-ops)
  #:use-module (gac sg1)
  #:use-module (srfi srfi-1)
  #:export (transpositions
            transpose-all
	    inversions
	    reverse-all
	    get-sc
	    append-sc
	    cons-sc
	    choose-sc
	    sc1+))

(define
  (transpositions l)
  (define
    (rot o)
    (map
     (lambda (e)
       (remainder (+ o e) 12)) l))
  (map rot (iota 12)))

(define (transpose-all chords)
  (map transpositions chords))

(define inversions
  '((0 . 0)
    (1 . 11)
    (2 . 10)
    (3 . 9)
    (4 . 8)
    (5 . 7)
    (6 . 6)))

;; todo add alpha mappings from morris' composition with pitch classes

(define
  (reverse-all lst)
  (map
   (lambda (x) (reverse x))
   lst))

(define (get-sc setclass position)
  (list-ref setclass position))

(define (append-sc sc1 sc2)
  (append sc1 sc2))

(define (cons-sc sc1 sc2)
  (cons sc1 sc2))

(define (choose-sc setclass)
  (list-ref setclass (random-integer (length setclass))))

;; this can be used with get-sc e.g. (sc1+ (get-sc %trichords 1))

(define (sc1+ setclass)
  (map (lambda (x) (1+ x))
       setclass))

'(defmacro (ntimes n generator)
 (make-list! n (lambda () ())))

(def (tcomplicated)
     (list (make-list! 3 (lambda () (choose-sc %trichords)))
           (make-list! 4 (lambda () (choose-sc %hexachords)))))

(def (t)
     (list (ntimes 3 (choose-sc %trichords))
           (ntimes 4 (choose-sc %hexachords))))


(def progression? (list-of (list-of integer?)))


;; (nrand-progession 3 %trichords 4 %tetrachords 6 %hexachords ...)
(def nrand-progression
     (lambda args -> progression?
        (pmatch
         args
         (pair?
          (let-list ((n chords . args*) args)
                    (append
                     (make-list! n (lambda () (choose-sc chords)))
                     (apply nrand-progression args*))))
         (null?
          '()))))


;; (car-cdr-chord %trichords)
(def (car-cdr-chord chord)
     "'(0 1 2) => '((0) (1 2))"
     (let ((chosen-chord (choose-sc chord)))
       ;; (list (list (car chosen-chord))
       ;;       (cdr chosen-chord))
       `((,(car chosen-chord))
         ,(cdr chosen-chord))))

;; (high-note-rest-chord %trichords)
(def (high-note-rest-chord chord)
     "'(0 1 2) => '((2) (0 1))"
     (let ((chosen-chord (choose-sc chord)))
       (cons (list (last chosen-chord))
             (list (butlast chosen-chord)))))

(def (expand-chord chord)
     "'(0 1 2) => '(-12 1 14)"
     "'(0 1 2 3) => '(-12 1 2 15)"
     (let ((chosen-chord (choose-sc chord)))
       (append (list (- (car chosen-chord) 12))
               (cdr (butlast chosen-chord))
               (list (+ (last chosen-chord) 12)))))

(def (expand-chords chord)
     (append (list (- (car chord) 12))
             (list  (cadr chord))
             (list (+ (last chord) 12))))
;; (def (expand-chord chord)
;;      (let ((chose-chord (choose-sc chord)))
;;        (append (- (car chosen-chord) 12)
;;                (list (cdr)))))

(def (intervals->chord [(ilist-of integer?) is] [integer? p0])
     ;; (-7 . (-6 -3 1 10))
     (cons p0 (if (null? is)
                  '()
                  (intervals->chord (cdr is)
                                    (+ (car is) p0)))))

(TEST
 > (intervals->chord '(1 3 4 9) -7)
 (-7 -6 -3 1 10))

'(def (chord->intervals))

'(def (foo? x)
     (and (number? x)
          (<= 10 x 30)))
