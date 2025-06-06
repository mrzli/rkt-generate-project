#lang racket/base

(require
  racket/path
  racket/file
  racket/contract
  "generate-project-input.rkt"
)

(provide
  (contract-out
    (get-full-path (-> generate-project-input? path?)))
)

(define (get-full-path input)
  (let [
      (input-path (generate-project-input-path input))
      (is-relative (generate-project-input-is-relative? input))]
    (if is-relative
      (let [(run-dir (path-only (find-system-path 'run-file)))]
        (simplify-path (build-path run-dir input-path)))
      input-path)))
