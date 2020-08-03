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
  (list-ref setclass (random (length setclass))))

;; this can be used with get-sc e.g. (sc1+ (get-sc %trichords 1))

(define (sc1+ setclass)
  (map (lambda (x) (1+ x)))
   setclass)
