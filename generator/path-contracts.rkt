#lang racket/base

(require
  racket/path
  racket/contract
)

(provide
  path-like?
)

(define path-like? (or/c string? path?))

