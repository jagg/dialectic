(defpackage utilities
  (:use :cl)
  (:export #:with-gensyms))

(in-package :utilities)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(mapcar #'(lambda (x) `(,x (gensym))) names)
     ,@body))


