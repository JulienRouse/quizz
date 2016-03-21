;;;; quizz.asd

(asdf:defsystem #:quizz
  :description "Little program that create quizz from a list of word. Created in the intent to learn vocabulary for a new language."
  :author "Julien Rousé"
  :license "WTFPL"
  :depends-on (#:split-sequence
	       #:alexandria
	       #:adw-charting
	       #:adw-charting-vecto
	       #:iterate)
  :serial t
  :components ((:file "package")
	       (:file "stats")
	       (:file "quizz")))

