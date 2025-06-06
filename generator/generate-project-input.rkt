#lang racket/base

(require
  racket/contract
  racket/path
  "path-contracts.rkt"
)

(provide
  (contract-out
    (struct generate-project-input
      (
        [path path-like?]
        [is-relative? boolean?]
        [data any/c]
      ))))

(struct generate-project-input
  (path is-relative? data)
  #:transparent)

;      [data data/c])]))

; ;; Define a contract for the data field
; (define data/c
;   (recursive-contract
;    (listof
;     (or/c
;      (list/c 'dir string? (listof data/c))
;      (list/c 'text string? string?)))))

; ;; Define the structure
; (struct generate-project-input
;   (path is-relative? data)
;   #:transparent)
