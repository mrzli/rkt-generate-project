#lang racket/base

(require
  racket/match
  racket/contract
  "../util/file.rkt"
)

(provide
  (contract-out
    (process-item (-> path? path? any/c void?))
  )
)

(define (process-item parent-path source-path item)
  (match item
    [`(dir ,name ,content)
     (process-dir (build-path parent-path name) source-path content)]
    [`(text ,name ,content)
     (with-output-to-file
      (build-path parent-path name)
      (lambda () (display content)) #:exists 'replace)]
    [`(copy ,name ,source-path-relative)
      (let (
          [source-full-path (build-path source-path source-path-relative)]
          [target-full-path (build-path parent-path name)])
        (unless (file-exists? source-full-path)
          (error "Source file does not exist:" source-full-path))
        (copy-file source-full-path target-full-path))]
    [other
      (error "Unknown data structure:" other)]))

(define (process-dir path source-path items)
  (recreate-dir path)
  (for-each (lambda (item) (process-item path source-path item)) items))
