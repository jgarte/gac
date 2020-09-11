(require easy
         read-csv)


(def (plant_species_gac_list_taxonomies-alist)
     (let-pair ((titles rows)
                (force (csv-file-stream
                        "/home/chris/tmp/plant_species_gac_list_taxonomies.csv")))
               (assert
                (equal? titles
                        '("Chord cardinality " "Plant family")))

               (=> rows
                   (.map (lambda (row)
                           (let-list ((card family) row)
                                     (cons (.symbol card)
                                           (.symbol family)))))
                   F)))


"
todo:
- csv import
- more aliases: all individual chords (but not the times (transpositions))
- auto finding of names in chords
(- maybe time of day functions for corresponding transpositions)
"
'(def (t)
     (let-pair ((titles rows)
                (force (csv-file-stream
                        "/home/chris/tmp/plant_species_gac_list.csv")))
               (assert
                (equal? titles
                        '("Set-class" "prime form" "Species " "Common name")))

               (.map rows
                     (lambda (row)
                       (let-list (()))))))

