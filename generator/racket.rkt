#lang racket/base

(require
  racket/file
  "util/date.rkt"
  "util/path.rkt"
  "npm/npm.rkt"
  "processing/process-item.rkt"
  "generate-project-input.rkt"
)

(define (generate-project input)
  (define target-path (get-full-path (generate-project-input-target-path input)))
  (define source-path (get-full-path (generate-project-input-source-path input)))
  (define data (generate-project-input-data input))

  (displayln (format "Generating project at: ~a" target-path))
  
  ; (when (directory-exists? target-path)
  ;   (delete-directory/files target-path))

  (make-directory* target-path)
  
  ; Process the project structure
  (process-item target-path source-path data)
)

(define timestamp (get-timestamp))
(define root-name (format "example_~a" timestamp))

(define data
  `(
    dir
    ,root-name
    (
      (text "file.txt" "This is an example file.")
      (copy "target.txt" "example.txt")
      (dir
        "subdir"
        ((text "subfile.txt" "This is a subfile in a subdirectory."))
      )
      ;(delete "file.txt")
      ;(delete (#px"^2tar"))
      ;(delete #rx"to-delete\\.txt")
      ;(delete (#rx"to-delete\\.txt"))
    )
    keep
  )
)

(define input
  (generate-project-input
    "./output"
    "./source"
    ; "/home/mrzli/projects/other/racket/rkt-generate-project/output"
    data
  )
)

; copy "./source/source" dir as root-name inside "./output" for testing
(copy-directory/files
  (get-full-path "./source/source")
  (get-full-path (build-path "./output" root-name))
)

(generate-project input)

(define version (get-npm-package-version "nx"))

version

(define regex `(#rx"bla"))

regex
