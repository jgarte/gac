(require easy
         plants-csv
         chords)

(defmacro (define-plant-aliases)
  `(begin
     ,@(.map (plant_species_gac_list_taxonomies-alist)
             (lambda-pair ((card family))
                     `(begin
                        (define ,card ,(symbol-append '% card))
                        (define ,family ,(symbol-append '% card)))))))

(define-plant-aliases)

