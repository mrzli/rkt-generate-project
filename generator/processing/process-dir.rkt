#lang racket/base

(require
  racket/match
  racket/file
  racket/contract
  "overwrite-strategy.rkt"
)

(provide
  (contract-out
    (process-dir
      (
        ->
        procedure?
        path?
        path?
        (listof any/c)
        overwrite-strategy?
        void?
      )
    )
  )
)

(define (process-dir process-item path source-path items overwrite-strategy)
  (displayln
    (format
      "Processing directory: ~a, ~a, ~a"
      path
      overwrite-strategy
      (directory-exists? path)
    ))
  (when (directory-exists? path)
    (match overwrite-strategy
      ['replace (delete-directory/files path)]
      ['keep (void)] ; Do nothing if 'keep
      ['error (error "Directory already exists and overwrite strategy is 'error: " path)]
      [other (error "Unknown overwrite strategy:" other)]))
  (unless (directory-exists? path)
    (make-directory* path))
  (for-each (lambda (item) (process-item path source-path item)) items))
