(defsystem "dialectic"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "dialectic/tests"))))

(defsystem "dialectic/tests"
  :author ""
  :license ""
  :depends-on ("dialectic"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for dialectic"
  :perform (test-op (op c) (symbol-call :rove :run c)))
