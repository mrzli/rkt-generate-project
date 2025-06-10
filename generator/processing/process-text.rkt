#lang racket/base

(require
  racket/match
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
  (when (file-exists? path)
    (match overwrite-strategy
      ['replace (delete-file path)]
      ['keep (void)] ; Do nothing
      ['error (error "File already exists and overwrite strategy is 'error: " path)]
      [other (error "Unknown overwrite strategy:" other)]))

  (unless (file-exists? path)
    (with-output-to-file
      path
      (lambda () (display content))
      #:exists 'error
    ))
)
