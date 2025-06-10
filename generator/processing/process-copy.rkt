#lang racket/base

(require
  racket/match
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

  (when (file-exists? target)
    (match overwrite-strategy
      ['replace (delete-file target)]
      ['keep (void)] ; Do nothing if 'keep
      ['error (error "File already exists and overwrite strategy is 'error: " target)]
      [other (error "Unknown overwrite strategy:" other)]))

  (unless (file-exists? target)
    (copy-file source target))
)
