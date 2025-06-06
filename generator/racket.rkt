#lang racket/base

(require
  racket/file
  "path.rkt"
  "generate-project-input.rkt"
)

(define (generate-project input)
  (define target-path (get-full-path input))
  (define data (generate-project-input-data input))

  (displayln (current-directory))

  ; (displayln data)
  
  (when (directory-exists? target-path)
    (delete-directory/files target-path))

  (make-directory* target-path)
  
  ; Process the project structure
  (process-item target-path data)
)

(define (process-dir path items)
  (make-directory* path)
  (for-each (lambda (item) (process-item path item)) items))

(define (process-item parent-path item)
  (define item-type (car item))
  (define item-name (cadr item))
  (define item-content (caddr item))

  (define full-path (build-path parent-path item-name))

  (cond
    [(eq? item-type 'dir)
     (process-dir full-path item-content)]
    [(eq? item-type 'text)
     (with-output-to-file full-path
      (lambda () (display item-content)) #:exists 'replace)]
    [else
     (error "Unknown item type: " item-type)]))

(define input
  (generate-project-input
    ; "../output"
    "/home/mrzli/projects/other/racket/rkt-generate-project/output"
    #f
    '(
      dir
      "example"
      (
        (text "file.txt" "This is an example file.")
        (dir
          "subdir"
          ((text "subfile.txt" "This is a subfile in a subdirectory."))
        )
      )
    )
  )
)

(generate-project input)
