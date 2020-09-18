(require easy)

(def (pitch-integer? v)
     (and (exact-integer? v)
          (<= -99 v 99)))

(def (pitchclass-integer? v)
     (and (exact-integer? v)
          (<= 0 v 11)))

(definterface pitchtype
  (defclass (pitch [pitch-integer? integer]))
  (defclass (pitchclass [pitchclass-integer? integer])))


(def chord? (list-of integer?))
