(require note)

(export lilyscore->file
        #!optional
        chord-display
        lilyscore-display)

(def lp-value? (either string? real?))

(def (keyword.lilypond-bag key)
     ;; XX should check for valid lilypond symbol names
     (list "\\" (keyword->string key)))

(def (lp-value.lilypond-bag v)
     (xcond ((string? v)
             ;; XX may not always be the right way to print strings for
             ;; lilypond
             (object->string v))
            ((real? v)
             (list "#" (object->string v)))))

(defclass (lp-setting [keyword? key] [lp-value? value])
  (defmethod (lilypond-bag _) -> string?
    (list (keyword.lilypond-bag key)
          " = "
          (lp-value.lilypond-bag value))))



(defclass (lp-instruction)
  (defclass (lp-version [string? value]))
  (defclass (lp-language [string? value]))
  (defclass (lp-header [(list-of lp-setting?) settings]))
  )

(defclass (lp-document [(list-of lp-instruction?) instructions]))
