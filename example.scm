(require pc-ops
         sg1
         lily)

(export chords->lilyscore
        chords->file
        lily)

(define (chords->lilyscore chords)
  `((#:version "2.18")
    (#:language "english")
    (#:header ((=tagline "")
               (=author "")))
    (#:score
     ((#:new Staff
             (lexps ,@chords))
      (#:layout ())
      (#:midi ())))))

;; (define (chords->file chords)
;;   (lilyscore->file (chords->lilyscore chords)))

(define debug? #t)

(define (chords->file chords file)
  (let ((sc (chords->lilyscore chords)))
    (when debug?
      (lilyscore-display sc (current-output-port)))
    (lilyscore->file sc file)))

(define (lily chords)
  (let ((file "chords.ly"))
    (chords->file chords file)
    (when (zero? (xsystem "lilypond" file))
      (xsystem "xpdf" (string-append (basename file ".ly") ".pdf")))))

