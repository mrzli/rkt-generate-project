#lang racket/base

(require
  json
  racket/contract
  "../util/command.rkt"
)

(provide
  (contract-out
    (get-npm-package-data (-> string? jsexpr?))
    (get-npm-package-version (-> string? string?))
  )
)

(define (get-npm-package-data package-name)
  (define npm-command (format "npm view ~a --json" package-name))
  (define npm-output (execute-to-string npm-command))
  (string->jsexpr npm-output)
)

(define (get-npm-package-version package-name)
  (define package-data (get-npm-package-data package-name))
  (define version (hash-ref package-data 'version))
  version
)