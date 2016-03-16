;;;; quizz.asd

(asdf:defsystem #:quizz
  :description "Describe quizz here"
  :author "Julien Rousé"
  :license "Specify license here"
  :depends-on (#:split-sequence
	       #:alexandria)
  :serial t
  :components ((:file "package")
               (:file "quizz")))

