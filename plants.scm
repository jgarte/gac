(require easy
         plants-csv
         sg1
         musictypes)

(defmacro (define-genus-aliases)
  `(begin
     ,@(.map (genus-alist)
             (lambda-pair ((card family))
                     `(begin
                        (define ,card ,(symbol-append '% card))
                        (define ,family ,(symbol-append '% card))
                        (define ,(=> family
                                     .string
                                     .downcase
                                     .symbol)
                          ,(symbol-append '% card)))))))

(define-genus-aliases)


(defmacro (define-species-aliases)
  `(begin
     ,@(.map (species-alist)
             (lambda-pair ((setclass species-variable-string))
                          (let ((species-variable (.symbol species-variable-string))
                                (species-variable-lc
                                 (.symbol
                                  (.downcase species-variable-string))))
                            `(begin
                               (define ,species-variable ',setclass)
                               (define ,species-variable-lc ,species-variable)))))))


(define-species-aliases)



(def genus-values-alist
     (map (lambda (p)
            (cons (eval (car p)) p))
          (genus-alist)))

(def species-values-alist
     (map (lambda (p)
            (let-pair ((setclass species-variable-name-string) p)
                      (cons setclass
                            (.symbol species-variable-name-string))))
          (species-alist)))

(def (maybe-show-genus [(list-of chord?) chs])
     (cond ((assoc chs genus-values-alist)
            => cdr)
           (else #f)))

(def (maybe-show-species [chord? ch])
     (cond ((assoc ch species-values-alist)
            => cdr)
           (else #f)))

(def chords? (list-of chord?))

(def (genus-chords? v)
     (and (chords? v)
          (maybe-show-genus v)
          #t))

(def (species-chord? v)
     (and (chord? v)
          (maybe-show-species v)
          #t))


(def. (genus-chords.show v show)
  (maybe-show-genus v))

(def. (species-chord.show v show)
  (maybe-show-species v))

(TEST
 > (show '(0 0 1))
 (list 0 0 1)
 > (show '(0 1 2))
 Ipomoea-hederifolia)



(def. (any.lily-annotate v)
  v)

(def. (list.lily-annotate v)
  (map .lily-annotate v))

(def. (genus-chords.lily-annotate v)
  (maybe-show-genus v))

(def. (species-chord.lily-annotate v)
  (xcond ((maybe-show-species v)
          => (lambda (species-variable)
               `(annotation
                 up
                 ,(variable-symbol->plain-name species-variable)
                 ,v)))))

(TEST
 > (.lily-annotate '(0 0 1))
 (0 0 1)
 > (.lily-annotate '(0 1 2))
 (annotation up "Ipomoea hederifolia" (0 1 2))
 > (.lily-annotate '((1 2 3) (0 1 2) (0) (3 4 5)))
 ((1 2 3)
  (annotation up "Ipomoea hederifolia" (0 1 2))
  (annotation up "Nymphaea odorata" (0))
  (3 4 5)))
