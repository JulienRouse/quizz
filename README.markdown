#QUIZZ


A little program that do quizz. I wrote it to learn vocabulary in a new language.


* [How to use it?](#how-to-use-it?)
* [API](#api)
* [TODO](#todo)


##How to use it?

This section assumes you use quicklisp. If you don't, you should! Download and learn about it [here](https://www.quicklisp.org/beta/).

While this library is not tracked by quicklisp, you can simply download the source code to your *local-projects* folder inside the quicklisp directory. Then simply:  
```lisp
>(ql:quickload :quizz)
(:QUIZZ)

>(quizz:play)
"Translate this word: hello"
...

```

You can then guess any number of time until you find the right answer.
You can also type in !quit to leave or !help to have a remainder of the existing command.

You must provide the words you want to take the quizz on.
The words must be in a file with comma separated value to be read correctly.
You can find my list of words in quizz/ressources/words.


##API

#### (play &key (filename #p"./ressources/words") (language 'lang1))	
     
Launch a quizz with the words found in the specified file.
language can be either 'lang1 or 'lang2 respectively the words of 
the first or second column that are used as question in the quizz

For example, if we have this in ./ressources/words:
```
hello;bonjour
```

Then the quizz can be:
```lisp
>(quizz:play) 
"Translate this word: hello"
"bonjour"
"correct! next:" ...
```

Or:
```lisp
>(quizz:play :language 'lang2)
"Translate this word: bonjour"
"hello"
"correct! next:" ...
```

##TODO

* Add a command !pass to pass when you don't know. 
* Add a command !hint to help find the word, maybe revealing the number of letter and/or one or more letter of the word.
* Maybe extend this to be able to support more languages in the csv file, to only write one time the words of each language if you want to learn multiples languages.
* Add tests.