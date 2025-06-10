#lang racket/base

(require
  "../generator/npm/npm.rkt"
)

(define version (get-npm-package-version "nx"))

version

(define regex `(#rx"bla"))

regex
