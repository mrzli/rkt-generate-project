#lang racket/base

(require
  racket/match
  racket/file
  racket/contract
  "process-dir.rkt"
  "process-text.rkt"
  "process-copy.rkt"
  "process-delete.rkt"
)

(provide
  (contract-out
    (process-item (-> path? path? any/c void?))
  )
)

(define (process-item parent-path source-path item)
  (define adjusted-item (adjust-item item))

  (match adjusted-item
    [`(dir ,name ,content ,overwrite-strategy)
      (process-dir process-item (build-path parent-path name) source-path content overwrite-strategy)]
    [`(text ,name ,content ,overwrite-strategy)
      (process-text (build-path parent-path name) content overwrite-strategy)]
    [`(copy ,name ,source-path-relative ,overwrite-strategy)
      (process-copy
        (build-path source-path source-path-relative)
        (build-path parent-path name)
        overwrite-strategy)]
    [`(delete ,pattern)
      (process-delete parent-path pattern)]
    [other
      (error "Unknown data structure:" other)]))

(define (adjust-item item)
  (match item
    [`(dir ,name ,content)
      `(dir ,name ,content replace)]
    [`(text ,name ,content)
      `(text ,name ,content replace)]
    [`(copy ,name ,source-path-relative)
      `(copy ,name ,source-path-relative replace)]
    [other
      item]))
