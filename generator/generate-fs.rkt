#lang racket/base

(require
  racket/file
  racket/contract
  "../util/path.rkt"
  "processing/process-item.rkt"
  "fs-input.rkt"
)

(provide
  (contract-out
    (generate-fs (-> fs-input? void?))
  )
)

(define (generate-fs input)
  (define target (get-full-path (fs-input-target input)))
  (define source (get-full-path (fs-input-source input)))
  (define data (fs-input-data input))

  (displayln (format "Generating file system entries at: ~a" target))

  (make-directory* target)
  
  (process-item target source data)
)
