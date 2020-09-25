(require note)

(export lilyscore->file
        #!optional
        chord-display
        lilyscore-display)

(def lp-value? (either string? real?))

(def. (keyword.lilypond-bag key)
     ;; XX should check for valid lilypond symbol names
     (list "\\" (keyword->string key)))

(def. (string.lilypond-bag v)
  ;; XX may not always be the right way to print strings for lilypond
  (object->string v))

(def. (real.lilypond-bag v)
  (list "#" (object->string v)))

(defclass (lp-setting [keyword? key] [lp-value? value])
  (defmethod (lilypond-bag _)
    (list (.lilypond-bag key)
          " = "
          (.lilypond-bag value)
          "\n")))

(TEST
 > (def (t v)
        (fst (with-output-to-string (lambda () (print (.lilypond-bag v))))))
 > (t (lp-setting foo: 234))
 "\\foo = #234\n"
 > (t (lp-setting foo: "234"))
 "\\foo = \"234\"\n")


(defclass lp-instruction
  (defclass (lp-version [string? value]))
  (defclass (lp-language [string? value]))
  (defclass (lp-header [(list-of lp-setting?) settings]))
  )

(defclass (lp-document [(list-of lp-instruction?) instructions]))

(TEST
 > (lp-document (list  
                 (lp-version "5.24.5")
                 (lp-language "english")
                 (lp-header (list (lp-setting tagline: "")
                                  (lp-setting author: "batman")))))
 [(lp-document)
  ([(lp-version) "5.24.5"]
   [(lp-language) "english"]
   [(lp-header) ([(lp-setting) tagline: ""]
                 [(lp-setting) author: "batman"])])])


"TODO
Near:
Make .lilypond-bag methods for lp-version lp-language, lp-header, and lp-document
Far:
create a type for lilypond version statement
create a type for lilypond language statement"

