#lang racket/base

(require
  racket/file
)

(provide
  recreate-dir
)

(define (recreate-dir path)
  (when (directory-exists? path)
    (delete-directory/files path))
  (make-directory* path))
