#lang racket/base

(require
  racket/file
  "../generator/util/path.rkt"
  "../generator/util/date.rkt"
  "../generator/generate-fs.rkt"
  "../generator/generate-fs-input.rkt"
)

(define timestamp (get-timestamp))
(define root-name (format "example_~a" timestamp))

(define data
  `(
    dir
    ,root-name
    (
      (text "file.txt" "This is an example file.")
      (text "file2.txt" "This is an example file 2." keep)
      (copy "target.txt" "example.txt" keep)
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
  (generate-fs-input
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

(generate-fs input)
