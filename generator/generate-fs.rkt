#lang racket/base

(require
  racket/file
  racket/contract
  "../util/path.rkt"
  "processing/process-item.rkt"
  "generate-fs-input.rkt"
)

(provide
  (contract-out
    (generate-fs (-> generate-fs-input? void?))
  )
)

(define (generate-fs input)
  (define target-path (get-full-path (generate-fs-input-target-path input)))
  (define source-path (get-full-path (generate-fs-input-source-path input)))
  (define data (generate-fs-input-data input))

  (displayln (format "Generating file system entries at: ~a" target-path))

  (make-directory* target-path)
  
  (process-item target-path source-path data)
)
