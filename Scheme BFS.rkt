#lang racket

; Created by Ryan Bender and Jacob Stephens;

; Part I. Move operators: up, down, left, right functions - Move the blank tile of a 9 space 3x3 list in the indicated direction
; Also implemented a swap function to switch out the blank tile with tile indicated by move function

(define (range start end)
  (if (>= start end)
      '()
      (cons start (range (+ start 1) end)))
  )

(define (find-blank state)
; Finds the index of the blank tile in the given state.
  (let loop ((lst state) (idx 0))
    (cond ((null? lst) #f)
          ((equal? (car lst) 'B) idx)
          (else (loop (cdr lst) (+ idx 1)))))
  )

(define (swap state i j)
; Swaps elements at positions i and j in the list and returns the new state.
  (let ((elem-i (list-ref state i))
        (elem-j (list-ref state j)))
    (map (lambda (k x)
           (cond ((= k i) elem-j)
                 ((= k j) elem-i)
                 (else x)))
         (range 0 (length state)) state))
  )

(define (up state)
; Moves the blank tile up if possible; otherwise returns ().
  (let ((blank-pos (find-blank state)))
    (if (< blank-pos 3)  ; Blank is in the top row
        '()
        (swap state blank-pos (- blank-pos 3))))
  )

(define (down state)
; Moves the blank tile down if possible; otherwise returns ().
  (let ((blank-pos (find-blank state)))
    (if (>= blank-pos 6)  ; Blank is in the bottom row
        '()
        (swap state blank-pos (+ blank-pos 3))))
  )

(define (left state)
; Moves the blank tile left if possible; otherwise returns ().
  (let ((blank-pos (find-blank state)))
    (if (= (remainder blank-pos 3) 0)  ; Blank is in the left column
        '()
        (swap state blank-pos (- blank-pos 1))))
  )


(define (right state)
; Moves the blank tile right if possible; otherwise returns ().
  (let ((blank-pos (find-blank state)))
    (if (= (remainder blank-pos 3) 2)  ; Blank is in the right column
        '()
        (swap state blank-pos (+ blank-pos 1))))
  )


; Part II. Breadth-first Search: Implemented a queue to keep track of visited states and states to visit; Used previous move functions to move B


(define (valid-state? state visited)
  (and (not (member state visited))
       (not (null? state)))
  )

(define (bfs queue visited goal)
  (if (null? queue)
      '()  ; No solution found
      (let* ((path (car queue))
             (state (car (reverse path))))
        (if (equal? state goal)
            path
            (let ((new-paths (filter (lambda (new-state)
                                        (valid-state? new-state visited))
                                      (map (lambda (move) (move state))
                                           (list up down left right)))))
              (bfs (append (cdr queue)
                           (map (lambda (new-state)
                                  (append path (list new-state)))
                                new-paths))
                   (append visited new-paths)
                   goal)))))
  )

(define (8puzzle initial goal)
  (bfs (list (list initial)) (list initial) goal)
  )


; Part III. Displaying the puzzle: Displays the puzzle as a matrix, wraps the normal 8puzzle function


(define (print8puzzle solution)
  (define (print-state state)
    (for ([i (range 0 3)])  ; Iterate over rows
      (for ([j (range 0 3)])  ; Iterate over columns
        (let ((tile (list-ref state (+ (* i 3) j))))  ; Calculate the correct index
          (display (if (equal? tile 'B) "  " (format "~a " tile)))))  ; Print blank space
      (newline)))  ; New line after each row

  (for ([step solution])  ; Iterate over each step in the solution
    (print-state step)  ; Print the current state
    (newline))  ; New line between states

(displayln (format "Total steps: ~a" (sub1 (+ (length solution) 1)))) ; Print total steps
  ) 
