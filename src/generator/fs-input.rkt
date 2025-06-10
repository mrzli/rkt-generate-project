#lang racket/base

(require
  racket/contract
  racket/path
  "../util/path-contracts.rkt"
)

(provide
  (contract-out
    (struct fs-input
      (
        [target path-like?]
        [source path-like?]
        [data any/c]
      ))))

(struct fs-input
  (target source data)
  #:transparent
)

;      [data data/c])]))

; ;; Define a contract for the data field
; (define data/c
;   (recursive-contract
;    (listof
;     (or/c
;      (list/c 'dir string? (listof data/c))
;      (list/c 'text string? string?)))))

; ;; Define the structure
; (struct generate-fs-input
;   (path is-relative? data)
;   #:transparent)
