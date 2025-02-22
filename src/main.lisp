(defpackage dialectic
  (:import-from :utilities #:with-gensyms)
  (:use :cl)
  (:export #:deftest #:check #:run-pkg #:run-all #:run))
(in-package :dialectic)

(defvar *current-test* "test")
(defvar *all-tests* (make-hash-table :test #'equal))

(defun report (result tst)
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *current-test* tst)
  result)

(defmacro check (&body exps)
  `(and ,@(mapcar #'(lambda (e) `(report ,e ',e)) exps)))

(defmacro deftest (name params &body body)
  `(progn
     (defun ,name  ,params
       (let ((*current-test* '(,(package-name *package*) ',name)))
         ,@body))
     (let ((*all-tests* (setf (gethash '(,(intern (package-name *package*)) ,name) *all-tests*) #',name))))))

(defun run (hash pred)
  (maphash (lambda (key fn)
             (if (funcall pred key) (funcall fn)))
           hash))

(defun run-all ()
  (run *all-tests* (lambda (x) x)))

(defun run-pkg (pkg)
  (run *all-tests* (lambda (p) (and (listp p)
                                    (eq pkg (first p))))))

;; Example

(deftest t1 ()
  (let ((x 2) (y 2) (z 4))
    (check
      (= x y)
      (= x z))))

(deftest t2 ()
  (let ((x 2))
    (check
      (= x x)
      (= x x))))

(run-all)

