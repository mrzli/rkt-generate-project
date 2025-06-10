#lang racket/base

(require
  racket/contract
  racket/path
  "util/path-contracts.rkt"
)

(provide
  (contract-out
    (struct generate-fs-input
      (
        [target-path path-like?]
        [source-path path-like?]
        [data any/c]
      ))))

(struct generate-fs-input
  (target-path source-path data)
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
