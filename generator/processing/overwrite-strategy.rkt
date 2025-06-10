#lang racket/base

(provide
  overwrite-strategy?
)

(define (overwrite-strategy? value)
  (member value '(replace keep error)))


