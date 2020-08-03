((
 (#:version "2.17.2")
 (#:glanguage "english")
 (c4 e4 g4))
 ^ weak typing
 
 (define-record-type language
   make-language language?
   (language-name language-language-name )
   )

 (make-language "english")
 ^ strong typing
 #<language 2349023u4  language-name "english">

 ^^ dynamic typing


 ML
 Haskell
 C++

 static typing

 - slow compilation
 - no (good) interactivity
 - difficulty to express some things
 - difficulty to develop (complicated type errors)

 hly 
 music-suite 
