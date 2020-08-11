(require pc-ops
         sg1
         lily)

(define (score-display chords #!optional (port (current-output-port)))
  (lilyscore-display
   `((#:version "2.18.2")
     (#:glanguage "english")
     (#:header ((=tagline "")
                (=author "")))
     (lexps ,@chords))
   port))

