#lang racket/base

(require
  racket/contract
)

(provide
  (contract-out
    (process-delete (-> path? delete-pattern/c void?))
  )
)

(define delete-pattern-single/c (or/c string? regexp? pregexp?))

(define delete-pattern/c (
  or/c 
    delete-pattern-single/c
    (listof delete-pattern-single/c)))

(define (process-delete parent-path pattern)
  (define entries (directory-list parent-path))
  (define names (map path->string entries))

  (define patterns
    (if (list? pattern)
      pattern
      (list pattern)))

  (for-each (lambda (p)
    (process-delete-single parent-path names p))
    patterns)
  
  (void)
)

(define (process-delete-single parent-path names pattern)
  (define matched-names
    (cond
      [(string? pattern)
       (filter (lambda (name) (string=? name pattern)) names)]
      [(or (regexp? pattern) (pregexp? pattern))
       (filter (lambda (name) (regexp-match? pattern name)) names)]
      [else
       (error "Unknown delete pattern type:" pattern)]))

  (for-each (lambda (name)
    (define entry-path (build-path parent-path name))
    (when (file-exists? entry-path)
      (delete-file entry-path)))
    matched-names)

  (void)
)
