;;;; quizz.lisp

(in-package #:quizz)

(defparameter *lang1-list* nil)
(defparameter *lang2-list* nil)
(defparameter *quizz-list* nil)
(defparameter *hint-level* 0)

(defun read-language-file (&key (filename #p"./ressources/words"))
  "Read into the csv containing the words and puts them in language separated lists"
  (with-open-file (in filename)
    (loop for line = (read-line in nil 'EOF)
	 until (eq line 'EOF)
	 do (let ((words-line (split-sequence:split-sequence #\; line)))
	      (setf *lang1-list* (append (list (nth 0 words-line)) *lang1-list*))
	      (setf *lang2-list* (append (list (nth 1 words-line)) *lang2-list*))))))


(defun create-alist (&key (language 'lang1))
  "create the associative list that contain all the pair of words and their traduction"
  (if (eq language 'lang1)
      (setf *quizz-list* (pairlis *lang1-list* *lang2-list*))
      (setf *quizz-list* (pairlis *lang2-list* *lang1-list*))))
	      
(defun ask-question (&key (language 'lang1))
  "Choose a random word in a list specified"
  (let ((key-list (if (eq language 'lang1)
		      *lang1-list*
		      *lang2-list*)))
    (nth (random (length key-list)) key-list)))
    
(defun give-hint (word)
  "Deliver hint to the user to help them find the word"
  (alexandria:switch (*hint-level* :test #'eql)
    (0 
     (incf *hint-level*)
     (format nil "First hint. This word is ~A letters long" (length word)))
    (1 
     (incf *hint-level*)
     (format nil "Second hint. This word first letter is ~c." (char word 0)))
    (otherwise
     (format nil "Third and last hint. This word first letter is ~c and the last letter is ~c" (char word 0) (char word (- (length word) 1))))))


(defun response (word)
  "Read input from the user until he use a command or find the right answer"  
  (let ((resp (read-line)))
    (alexandria:switch (resp :test #'string=)
      ("!quit" resp)
      (word 
       (setf *hint-level* 0)
       resp)
      ("!help" 
       (print (instruction))
       (response word))
      ("!pass" resp)
      ("!hint" 
       (print (give-hint word))
       (response word))
      (otherwise 
       (response word)))))


(defun instruction ()
  "Find the correct word.
 Commands are: 
 -!help to get help 
 -!pass to pass the word and see the right answer
 -!hint to get hints like number of letter in the word, then first letter, then last letter. 
 -!quit to exit.")

(defun loop-default (&key (language 'lang1))
  (let ((current-question (ask-question :language language)))
    (print "Translate this word: ")
    (print current-question)
    (let* ((valid-answer (cdr (assoc current-question *quizz-list* :test #'string=)))
	   (res (response valid-answer)))
      (alexandria:switch (res :test #'string=) 
	("!quit" 
	 (clean-data)
	 (print valid-answer))
	("!pass"  
	 (print "Answer was:")
	 (print valid-answer)
	 (loop-default :language language))
	(valid-answer 
	 (print "correct! next:")
	 (loop-default :language language)))))
  nil)

(defun clean-data ()
  "Reset the global defparameter. Used before playing the quizz"
  (setf *lang1-list* nil)
  (setf *lang2-list* nil)
  (setf *quizz-list* nil))    

(defun play (&key (filename #p"./ressources/words") (language 'lang1) )
  "Main entry into the quizz. Loads the file specified, and build the quizz"
  (print (instruction))
  (clean-data)
  (read-language-file :filename filename)
  (create-alist :language language)
  (loop-default :language language))


