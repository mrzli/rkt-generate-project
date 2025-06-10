#lang racket/base

(require
  racket/port
  racket/system
  racket/contract
)

(provide
  (contract-out
    (execute-to-string (-> string? string?))
  ))

(define (execute-to-string command)
  (with-output-to-string
    (lambda () (system command))))
