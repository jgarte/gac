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

(def (variable-symbol->plain-name [symbol? str])
     (=> str
         .string
         .list
         (.map (lambda (c)
                 (case c
                   ((#\-) #\space)
                   (else
                    c))))
         .string))

(TEST
 > (plain-name->variable-name "Foo bar")
 "Foo-bar"
 > (variable-symbol->plain-name (.symbol #))
 "Foo bar")


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


