;;;; quizz.lisp

(in-package #:quizz)

(defparameter *lang1-list* nil)
(defparameter *lang2-list* nil)
(defparameter *quizz-list* nil)


(defun read-language-file (&key (filename #p"./ressources/words"))
  "Read into the csv containing the words and puts them in language separated lists"
  (with-open-file (in filename)
    (loop for line = (read-line in nil 'EOF)
	 until (eq line 'EOF)
	 do (let ((words-line (split-sequence:split-sequence #\; line)))
	      (setf *lang1-list* (append *lang1-list* (list (nth 0 words-line))))
	      (setf *lang2-list* (append *lang2-list* (list (nth 1 words-line))))))))


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
    
(defun response (word)
  "Wait for an input on the default input stream."
  (let ((resp ""))
    (loop while (and (not (string= resp "!quit"))
		     (not (string= resp "!help"))
		     (not (string= resp word)))
       do 
	 (setf resp (read-line)))
    resp))

(defun instruction ()
  "Find the correct word. Type !help to get help and !quit to exit.")

(defun loop-default (&key (language 'lang1))
  (let ((current-question (ask-question :language language)))
    (print "translate this word: ")
    (print current-question)
    (let* ((valid-answer (cdr (assoc current-question *quizz-list* :test #'string=)))
	   (res (response valid-answer)))
      (alexandria:switch (res :test #'string=) 
	("!quit" 
	 (clean-data)
	 (print valid-answer))
	("!help"  
	 (print (instruction))
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

(defun play (&key (filename #p "./ressources/words") (language 'lang1) )
  "Main entry into the quizz. Loads the file specified, and build the quizz"
  (clean-data)
  (read-language-file :filename filename)
  (create-alist :language language)
  (loop-default :language language))
