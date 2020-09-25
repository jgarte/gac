(require pc-ops
         sg1
         lily
         plants)

(export chords->lilyscore
        chords->file
        lily)

(def (maybe-program-path progname) -> (maybe string?)
     (letv ((path statuscode) (Xbacktick "which" progname))
           (if (zero? statuscode)
               path
               #f)))

(define pdf-viewer
  (or (maybe-program-path "zathura")
      (maybe-program-path "xpdf")
      "xdg-open"))

;; (def (Maybe-program-path progname) -> (Maybe string?)
;;   (letv ((path statuscode) (Xbacktick "which" progname))
;;         (if (zero? statuscode)
;;             (Just path)
;;             (Nothing))))

;; (define (find-program prognames)
;;   (=> (stream-map Maybe-program-path prognames)
;;       (.filter Just?)
;;       .first
;;       .value))

(define (find-program prognames)
  (if (null? prognames)
      (error "couldn't find any of the given programs")
      (or (maybe-program-path (car prognames))
          (find-program (cdr prognames)))))


(define pdf-viewer (find-program '("zathura" "xpdf" "xdg-open")))

;; (define (chords->file chords)
;;   (lilyscore->file (chords->lilyscore chords)))

(define debug? #t)

(define (chords->lilyscore chords)
  `((version: "2.18")
    (language: "english")
    (header: ((=tagline "")
              (=author "")))
    (score:
     ((new: Staff
            (,@chords))
      (layout: ())
      (midi: ())))))

(define (chords->file chords file)
  (let ((sc (chords->lilyscore chords)))
    (when debug?
      (lilyscore-display sc (current-output-port)))
    (lilyscore->file sc file)))

(define (_lily chords)
  (let ((file "chords.ly"))
    (chords->file chords file)
    (when (zero? (xsystem "lilypond" file))
      (xsystem pdf-viewer (string-append (basename file ".ly") ".pdf")))))

(define (lily chords)
  (_lily (.lily-annotate chords)))

