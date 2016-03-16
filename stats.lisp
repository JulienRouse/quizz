;;;;stats.lisp

(in-package #:quizz)


;;store a list with 4 numbers:
;;-number of good answer
;;-number of bad answer
;;-number of !pass
;;-number of !hint
(defparameter *simple-stats* (list 0 0 0 0))


;;(decode-universal-time (get-universal-time)) 
;;for later use


;;four accessors for the four values in *simple-stats*
(defun get-number-good-answer ()
  (first *simple-stats*))

(defun get-number-bad-answer ()
  (second *simple-stats*))

(defun get-number-pass ()
  (third *simple-stats*))

(defun get-number-hint ()
  (fourth *simple-stats*))


