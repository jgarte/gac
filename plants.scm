(require easy
         plants-csv
         sg1)

(defmacro (define-plant-aliases)
  `(begin
     ,@(.map (plant_species_gac_list_taxonomies-alist)
             (lambda-pair ((card family))
                     `(begin
                        (define ,card ,(symbol-append '% card))
                        (define ,family ,(symbol-append '% card))
                        (define ,(=> family
                                     .string
                                     .downcase
                                     .symbol)
                          ,(symbol-append '% card)))))))

(define-plant-aliases)

