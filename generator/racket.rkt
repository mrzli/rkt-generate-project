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

(define data
  `(
    dir
    ,(format "example_~a" timestamp)
    (
      (text "file.txt" "This is an example file.")
      (copy "target.txt" "example.txt")
      (dir
        "subdir"
        ((text "subfile.txt" "This is a subfile in a subdirectory."))
      )
    )
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

(generate-project input)

(define version (get-npm-package-version "nx"))

version
