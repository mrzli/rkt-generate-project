#lang racket/base

(require
  racket/file
  racket/match
  "util/date.rkt"
  "util/path.rkt"
  "util/file.rkt"
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

(define (process-item parent-path source-path item)
  (define item-type (car item))
  (define item-name (cadr item))
  (define item-content (caddr item))

  (define full-path (build-path parent-path item-name))

  (cond
    [(eq? item-type 'dir)
     (process-dir full-path source-path item-content)]
    [(eq? item-type 'text)
     (with-output-to-file full-path
      (lambda () (display item-content)) #:exists 'replace)]
    [else
     (error "Unknown item type: " item-type)]))

(define (process-dir path source-path items)
  (recreate-dir path)
  (for-each (lambda (item) (process-item path source-path item)) items))

(define timestamp (get-timestamp))

(define input
  (generate-project-input
    "./output"
    "./source"
    ; "/home/mrzli/projects/other/racket/rkt-generate-project/output"
    `(
      dir
      ,(format "example_~a" timestamp)
      (
        (text "file.txt" "This is an example file.")
        ; (copy "example.txt" "from-source.txt")
        (dir
          "subdir"
          ((text "subfile.txt" "This is a subfile in a subdirectory."))
        )
      )
    )
  )
)

(generate-project input)
