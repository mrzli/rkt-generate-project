#lang racket/base

(require
  racket/file
  racket/match
  "util/date.rkt"
  "util/path.rkt"
  "util/file.rkt"
  "generate-project-input.rkt"
  "npm/npm.rkt"
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

(define (process-item parent-path source-path item)
  (match item
    [`(dir ,name ,content)
     (process-dir (build-path parent-path name) source-path content)]
    [`(text ,name ,content)
     (with-output-to-file
      (build-path parent-path name)
      (lambda () (display content)) #:exists 'replace)]
    [`(copy ,name ,source-path-relative)
      (let (
          [source-full-path (build-path source-path source-path-relative)]
          [target-full-path (build-path parent-path name)])
        (unless (file-exists? source-full-path)
          (error "Source file does not exist:" source-full-path))
        (copy-file source-full-path target-full-path))]
    [other
      (error "Unknown data structure:" other)]))

(define (process-dir path source-path items)
  (recreate-dir path)
  (for-each (lambda (item) (process-item path source-path item)) items))

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
