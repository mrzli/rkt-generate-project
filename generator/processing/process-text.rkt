#lang racket/base

(require
  racket/file
  racket/contract
  "overwrite-strategy.rkt"
)

(provide
  (contract-out
    (process-text (-> path? string? overwrite-strategy? void?))
  )
)

(define (process-text path content overwrite-strategy)
  (with-output-to-file
    path
    (lambda () (display content))
    #:exists 'replace
  )
)
