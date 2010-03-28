#lang typed-scheme
(require "../hood-melville-queue.ss")
(require typed/test-engine/scheme-tests)

(check-expect (empty? empty) #t)
(check-expect (empty? (queue 1)) #f)
(check-expect (empty? (queue 1 2)) #f)

(check-expect (head (queue 4 5 2 3)) 4)
(check-expect (head (queue 2)) 2)  

(check-expect (queue->list (tail (queue 4 5 2 3)))
              (list 5 2 3))
(check-expect (queue->list (tail (queue 1))) null)
(check-error (tail empty) "Queue is empty : tail")

(check-expect (queue->list (enqueue 1 empty)) (list 1))
(check-expect (queue->list (enqueue 1 (queue 1 2 3))) (list 1 2 3 1))

(check-expect (head (enqueue 1 empty)) 1)
(check-expect (head (enqueue 10 (queue 5 2 3))) 5)

(check-error (head empty) "Queue is empty : head")

(define lst (build-list 100 (λ: ([x : Integer]) x)))

(check-expect (queue->list (apply queue lst)) lst)

(test)