(defpackage dialectic/tests/main
  (:use :cl
        :dialectic
        :rove))
(in-package :dialectic/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :dialectic)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
