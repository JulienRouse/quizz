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

(defun reset-stats ()
  (setf *simple-stats* (list 0 0 0 0)))


(defun read-stats (&key (filename #p"./ressources/stats"))
  (with-open-file (in filename :direction :input :if-does-not-exist :create)
    (let ((line (read-line in nil)))
      (if (null line)
	  (reset-stats)
	  (let ((line-split (split-sequence:split-sequence #\; line)))
	    (setf (first *simple-stats*)  (parse-integer (first line-split)))
	    (setf (second *simple-stats*) (parse-integer (second line-split)))
	    (setf (third *simple-stats*)  (parse-integer (third line-split)))
	    (setf (fourth *simple-stats*) (parse-integer (fourth line-split)))
	    *simple-stats*)))))


(defun write-stats (&key (filename #p"./ressources/stats"))
  (with-open-file (out filename :direction :output :if-exists :supersede)
    (format out 
	    "~A;~A;~A;~A" 
	    (get-number-good-answer)
	    (get-number-bad-answer)
	    (get-number-pass)
	    (get-number-hint))))


;;do i want them with exact ratio or an approximate float?
(defun %percentage (sum num)
  (float (/ num sum)))

(defun percentage ()
  (let ((sum (+ (get-number-good-answer)
		(get-number-bad-answer)
		(get-number-pass)
		(get-number-hint))))
    (values (%percentage sum (get-number-good-answer))
	    (%percentage sum (get-number-bad-answer))
	    (%percentage sum (get-number-pass))
	    (%percentage sum (get-number-hint)))))





