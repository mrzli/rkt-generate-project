#lang racket/base

(require
  racket/match
  racket/contract
  "../util/json.rkt"
)

(provide
  (contract-out
    (convert-fs (-> any/c any/c))
  )
)

(define (convert-fs input-data)
  (match input-data
    [`(dir ,name, items)
      `(dir ,name ,(map convert-fs items))]
    [`(dir ,name, items ,overwrite-strategy)
      `(dir ,name ,(map convert-fs items) ,overwrite-strategy)]
    [`(json ,name ,data)
      `(text ,name ,(json->pretty-string data))]
    [`(json ,name ,data ,overwrite-strategy)
      `(text ,name ,(json->pretty-string data) ,overwrite-strategy)]
    [other other])
)
