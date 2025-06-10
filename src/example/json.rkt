#lang racket

(require
  json
)

; (define json-data
;   (hasheq 'object (hasheq 'key "value")
;           'array (list "item1" 42 #t 'null)
;           'string "Hello, World!"
;           'number 3.14
;           'boolean #t
;           'null 'null))

(define json-data
  #hash(
    (object . #hash((key . "value")))
    (array . ("item1" 42 #t null))
    (string . "Hello, World!")
    (number . 3.14)
    (boolean . #t)
    (null . null)))

; (define json-data
;   #hash((boolean . #hash((key . "value")))))

(println json-data)

(displayln (jsexpr->string json-data #:indent 2))
