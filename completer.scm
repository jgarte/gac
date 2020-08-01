(define-module (gac sg1)
  #:use-module (srfi srfi-1)

  #:export (%dyads
            %decachords
            %trichords
            transpose-all))

(define %dyads '((0 1) (0 2) (0 3) (0 4) (0 5) (0 6)))

(define %decachords '((0 1 2 3 4 5 6 7 8 9)
                      (0 1 2 3 4 5 6 7 8 10)
                      (0 1 2 3 4 5 6 7 9 10)
                      (0 1 2 3 4 5 6 8 9 10)
                      (0 1 2 3 4 5 7 8 9 10)
                      (0 1 2 3 4 6 7 8 9 10)))

(define %trichords '((0 1 2) (0 1 3) (0 2 3) (0 1 4)
                     (0 3 4) (0 1 5) (0 4 5) (0 1 6)
                     (0 5 6) (0 2 4) (0 2 5) (0 3 5)
                     (0 2 6) (0 4 6) (0 2 7) (0 3 6)
                     (0 3 7) (0 4 7) (0 4 8)))

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

(transpose-all %dyads)
(transpose-all %trichords)
(transpose-all %decachords)

;; (define
;;   (transpositions l)
;;   (letrec
;;       ((rot
;;         (lambda (o)
;;           (map
;;            (lambda (e)
;;              (remainder (+ o e) 12))
;;            l))))
;;     (map rot (iota 12))))


(unfold
 (lambda (xs)
   (= (car xs) 12))
 values
 (lambda (xs) (map 1+ xs))
 '(0 1 2))

(map (lambda (i) (list i (remainder (+ 1 i) 12) (remainder (+ 2 i) 12))) (iota 12))

(let
    loop
  ((res '())
   (i1 0)
   (i2 1)
   (i3 3)
   (cnt 12))
  (if (zero? cnt)
      res
      (loop
       (cons (list i1 i2 i3) res)
       (1+ i1)
       (1+ i2)
       (1+ i3)
       (1- cnt))))

(if (zero? cnt) res" => (if (zero? cnt) (reverse res)

(define (transpositions l) (letrec ((rot (lambda (o) (map (lambda (e) (remainder (+ o e) 12)) l)))) (map rot (iota 12))))

(modulo 13 12)

(unfold (lambda (x) (> x 10))
        (lambda (x) (* x x))
	      (lambda (x) (+ x 1))
	      1)

(define s0 (list-ref 3-1 0))
(define s1 (list-ref 3-1 1))
(define s2 (list-ref 3-1 2))
(define s3 (list-ref 3-1 3))
(define s4 (list-ref 3-1 4))
(define s5 (list-ref 3-1 5))
(define s6 (list-ref 3-1 6))
(define s7 (list-ref 3-1 7))
(define s8 (list-ref 3-1 8))
(define s9 (list-ref 3-1 9))
(define s10 (list-ref 3-1 10))
(define s11 (list-ref 3-1 11))

(define c0 (list-ref 9-1 0))
(define c1 (list-ref 9-1 1))
(define c2 (list-ref 9-1 2))
(define c3 (list-ref 9-1 3))
(define c4 (list-ref 9-1 4))
(define c5 (list-ref 9-1 5))
(define c6 (list-ref 9-1 6))
(define c7 (list-ref 9-1 7))
(define c8 (list-ref 9-1 8))
(define c9 (list-ref 9-1 9))
(define c10 (list-ref 9-1 10))
(define c11 (list-ref 9-1 11))


(define a0 (append s0 c0))
(define a1 (append s1 c1))
(define a2 (append s2 c2))
(define a3 (append s3 c3))
(define a4 (append s4 c4))
(define a5 (append s5 c5))
(define a6 (append s6 c6))
(define a7 (append s7 c7))
(define a8 (append s8 c8))
(define a9 (append s9 c9))
(define a10 (append s10 c10))
(define a11 (append s11 c11))

(define b0 (cons s0 c0))
(define b1 (cons s1 c1))
(define b2 (cons s2 c2))
(define b3 (cons s3 c3))
(define b4 (cons s4 c4))
(define b5 (cons s5 c5))
(define b6 (cons s6 c6))
(define b7 (cons s7 c7))
(define b8 (cons s8 c8))
(define b9 (cons s9 c9))
(define b10 (cons s10 c10))
(define b11 (cons s11 c11))

(reverse b0)

(identity b0)

(define (choose-three)
  (list-ref 3-1 (random 12)))

(define (choose-nine)
  (list-ref 9-1 (random 12)))

(define (choose-three-nine)
  (cons (choose-three) (choose-nine)))

(choose-three-nine)

(reverse (append b0 b1))
(display b0)
(display b1)

;; add hash map for converting to lilypond tokens
;; add keyword argument for choosing between cons and append

(identity a0)

(identity 3-1)

(define
  (reverse-all lst)
  (map
   (lambda (x) (reverse x))
   lst))

(define
  (transpose lst)
  (map
   (lambda (x) (reverse x))
   lst))

(reverse-all 3-1)

(define
  (transpose lst)
  (map
   (lambda (x) (1+ (identity x)))
   lst))


(define s0 (list-ref 3-1 0))

(list-ref 3-1 15)

(car 3-1)

(length 3-1)


(if (= (random 2) 0)
    (if (= (random 12) 6)
        "play a soft note"
        "play a loud note")
    "play a high note")

(transpose 3-1)

(reverse 3-1)

(reverse-all 3-1)

(map 1+ '(1 2 3))

(cons s0 s1)
(append s0 s1)
