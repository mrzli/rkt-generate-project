#lang racket/base

(require
  racket/path
  racket/file
  racket/contract
  "path-contracts.rkt"
)

(provide
  (contract-out
    (get-full-path (-> path-like? path?)))
)

(define (get-full-path path)
  (simplify-path (path->complete-path path)))
