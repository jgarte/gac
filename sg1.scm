(define-module (gac sg1)
  #:use-module (srfi srfi-1)

  #:export (%monad
            %dyads
            %trichords
            %tetrachords
            %pentachords
            %hexachords
            %septachords
            %octachords
            %nonachords
            %decachords
            %undecachords
            %dodecachord))

(define %dyads '((0 1) (0 2) (0 3) (0 4) (0 5) (0 6)(0 7) (0 8) (0 9) (0 10) (0 11)))

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
