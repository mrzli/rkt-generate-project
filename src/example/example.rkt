#lang racket/base

(require
  racket/match
  "../project/npm.rkt"
)

(define version (get-npm-package-version "nx"))

version

(define regex `(#rx"bla"))

regex

(match '((a . b) (c . d) e)
  [(list (cons _ _) ... @ value)
   (printf "~a" value)]
  [_ (error "Unexpected structure")])
