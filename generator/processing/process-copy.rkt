#lang racket/base

(require
  racket/file
  racket/contract
  "overwrite-strategy.rkt"
)

(provide
  (contract-out
    (process-copy (-> path? path? overwrite-strategy? void?))
  )
)


(define (process-copy source target overwrite-strategy)
  (unless (file-exists? source)
    (error "Source file does not exist:" source))
  (copy-file source target)
)
