#lang racket/base

(require
  racket/date
  racket/format
)

(provide
  get-timestamp
)

(define (get-timestamp) (current-milliseconds))
