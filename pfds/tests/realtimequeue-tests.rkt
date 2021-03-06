#lang typed-scheme
(require pfds/queue/real-time)
(require typed/test-engine/scheme-tests)

(check-expect (empty? (empty Integer)) #t)
(check-expect (empty? (queue 1)) #f)
(check-expect (head (queue 1)) 1)
(check-error (head (empty Integer)) "head: given queue is empty")
(check-expect (head (queue 1 2)) 1)
(check-expect (head (queue 10 2 34 55)) 10)

(check-expect (queue->list (tail (queue 1))) null)
(check-error (tail (empty Integer)) "tail: given queue is empty")
(check-expect (queue->list (tail (queue 10 12))) (list 12))
(check-expect (queue->list (tail (queue 23 45 -6))) (list 45 -6))
(check-expect (queue->list (tail (queue 23 45 -6 15))) 
              (list 45 -6 15))

(check-expect (queue->list (enqueue 10 (queue 23 45 -6 15))) 
              (list 23 45 -6 15 10))
(check-expect (queue->list (enqueue 10 (empty Integer))) (list 10))

(check-expect (queue->list (enqueue 10 (queue 20))) 
              (list 20 10))

(check-expect (queue->list (apply queue (build-list 100 (λ(x) x))))
              (build-list 100 (λ(x) x)))

(check-expect (queue->list (map + (queue 1 2 3 4 5) (queue 1 2 3 4 5)))
              (list 2 4 6 8 10))

(check-expect (queue->list (map - (queue 1 2 3 4 5) (queue 1 2 3 4 5)))
              (list 0 0 0 0 0))

(check-expect (fold + 0 (queue 1 2 3 4 5)) 15)


(check-expect (queue->list (filter positive? (queue 1 2 -4 5 0 -6 12 3 -2)))
              (list 1 2 5 12 3))

(check-expect (queue->list (filter negative? (queue 1 2 -4 5 0 -6 12 3 -2)))
              (list -4 -6 -2))

(check-expect (queue->list (remove positive? (queue 1 2 -4 5 0 -6 12 3 -2)))
              (list -4 0 -6 -2))

(check-expect (queue->list (remove negative? (queue 1 2 -4 5 0 -6 12 3 -2)))
              (list 1 2 5 0 12 3))
(check-expect (fold + 0 (queue 1 2 3 4 5) (queue 1 2 3 4 5)) 30)
(test)
