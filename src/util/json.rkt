#lang racket/base

(require
  racket/contract
  json
)

(provide
  (contract-out
    (json->pretty-string (-> any/c string?))
  )
)

(define (json->pretty-string data)
  (jsexpr->string data #:indent 2))