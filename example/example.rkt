#lang racket/base

(require
  "../project/npm.rkt"
)

(define version (get-npm-package-version "nx"))

version

(define regex `(#rx"bla"))

regex
