(require easy
         read-csv
         read-csv-util)


(def (genus-alist)
     (let-pair ((titles rows)
                (force (csv-file-stream "genus.csv")))
               (assert
                (equal? titles
                        '("Chord cardinality " "Plant family")))

               (=> rows
                   (.map (lambda (row)
                           (let-list ((card family) row)
                                     (cons (.symbol card)
                                           (.symbol family)))))
                   F)))



(def (plain-name->variable-name [string? str])
     (=> (.list str)
         (.map (lambda (c)
                 (case c
                   ((#\space) #\-)
                   (else
                    c))))
         .string))

(TEST
 > (plain-name->variable-name "Foo bar")
 "Foo-bar")

"
todo:
- csv import
- more aliases: all individual chords (but not the times (transpositions))
- auto finding of names in chords
(- maybe time of day functions for corresponding transpositions)
"
(def (species-alist)
     (let-pair ((titles rows) (force (csv-file-stream "species.csv")))

               (assert (equal? titles
                               '("Set class" "Species")))

               (=> (.map rows
                         (lambda (row)
                           (if (read-csv-util:list-empty? row)
                               (Nothing)
                               (Just
                                (let-list ((setclass species) row)
                                          (cons (call-with-input-string setclass read-all)
                                                (plain-name->variable-name
                                                 (trim-both species))))))))
                   F
                   cat-Maybes)))



'(def (f v)
     (if (pair? v)
         ;; instead of: (+ (* (car v) (cdr v)) (* 5 (cdr v)) 10)
         (let ((x (car v))
               (y (cdr v)))
           (+ (* x y) (* 5 y) 10))
         '()))

(def (f1 a b c)
      (let (v (read))
       (let ((x (car v))
             (y (cdr v)))
         (+ (* x y) (* 5 y) 10))))

(def (f2 a b c)
      (let-pair ((x y) (read))
        (+ (* x y) (* 5 y) 10)))


(def (f3 a b c)
      (let ((x (car (read)))
            (y (cdr (read))))
        (+ (* x y) (* 5 y) 10)))

