(require 2htdp/image)
(require 2htdp/universe)
(define FROG .)
(define HALF-FROG-W (/ (image-width FROG) 2))
(define HALF-FROG-H (/ (image-height FROG) 2))
(define CAR-L .)
(define CAR-R .)
(define HALF-CAR-W (/ (image-width CAR-L) 2))
(define HALF-CAR-H (/ (image-height CAR-L) 2))
(define LOG .)
(define HALF-LOG-W (/ (image-width LOG) 2))
(define HALF-LOG-H (/ (image-height LOG) 2))
(define TURTLE .)
(define HALF-TURTLE-W (/ (image-width TURTLE) 2))
(define HALF-TURTLE-H (/ (image-height TURTLE) 2))
(define CAR-SPEED 3)
(define PLAT-SPEED 3)
(define BKGD-W 800)
(define HALF-BKGD-W (/ BKGD-W 2))
(define BKGD-H 650)
(define ROW (/ BKGD-H 13))
(define ROW1 (* 0.5 ROW))
(define ROW2 (* 1.5 ROW))
(define ROW3 (* 2.5 ROW))
(define ROW4 (* 3.5 ROW))
(define ROW5 (* 4.5 ROW))
(define ROW6 (* 5.5 ROW))
(define ROW7 (* 6.5 ROW))
(define ROW8 (* 7.5 ROW))
(define ROW9 (* 8.5 ROW))
(define ROW10 (* 9.5 ROW))
(define ROW11 (* 10.5 ROW))
(define ROW12 (* 11.5 ROW))
(define ROW13 (* 12.5 ROW))
(define TXT-SIZE 30)
(define WIN-TXT "YOU WIN")
(define LOSE-TXT "YOU LOSE")
(define BKGD-COLOR "black")
(define GRASS (rectangle BKGD-W ROW "solid" "dark green"))
(define WATER (rectangle BKGD-W (* ROW 5) "solid" "dark blue"))
(define LINE (rectangle BKGD-W 3 "solid" "light goldenrod"))
(define BKGD (place-images
              (list LINE LINE LINE LINE GRASS WATER)
              (list (make-posn HALF-BKGD-W (* ROW 8))
                    (make-posn HALF-BKGD-W (* ROW 9))
                    (make-posn HALF-BKGD-W (* ROW 10))
                    (make-posn HALF-BKGD-W (* ROW 11))
                    (make-posn HALF-BKGD-W ROW7)
                    (make-posn HALF-BKGD-W ROW4))
              (overlay/align "middle" "top" GRASS
                             (overlay/align "middle" "bottom" GRASS
                                            (rectangle BKGD-W BKGD-H "solid" BKGD-COLOR)))))
(define START-IMG (place-images (list
                                 LOG LOG LOG LOG
                                 TURTLE TURTLE TURTLE TURTLE
                                 LOG LOG LOG LOG
                                 TURTLE TURTLE TURTLE TURTLE
                                 LOG LOG LOG LOG
                                 CAR-L CAR-L CAR-L CAR-L
                                 CAR-R CAR-R CAR-R CAR-R
                                 CAR-L CAR-L CAR-L CAR-L
                                 CAR-R CAR-R CAR-R CAR-R
                                 CAR-L CAR-L CAR-L CAR-L
                                 FROG)
                                (list
                                 ; row 2 R
                                 (make-posn 0 ROW2) (make-posn (* BKGD-W .25) ROW2)
                                 (make-posn (* BKGD-W .5) ROW2) (make-posn (* BKGD-W .75) ROW2)
                                 ; row 3 L
                                 (make-posn (* BKGD-W .25) ROW3) (make-posn (* BKGD-W .5) ROW3)
                                 (make-posn (* BKGD-W .75) ROW3) (make-posn BKGD-W ROW3)
                                 ; row 4 R
                                 (make-posn 0 ROW4) (make-posn (* BKGD-W .25) ROW4)
                                 (make-posn (* BKGD-W .5) ROW4) (make-posn (* BKGD-W .75) ROW4)
                                 ; row 5 L
                                 (make-posn (* BKGD-W .25) ROW5) (make-posn (* BKGD-W .5) ROW5)
                                 (make-posn (* BKGD-W .75) ROW5) (make-posn BKGD-W ROW5)
                                 ; row 6 R
                                 (make-posn 0 ROW6) (make-posn (* BKGD-W .25) ROW6)
                                 (make-posn (* BKGD-W .5) ROW6) (make-posn (* BKGD-W .75) ROW6)
                                 ; row 8 L
                                 (make-posn (* BKGD-W .25) ROW8) (make-posn (* BKGD-W .5) ROW8)
                                 (make-posn (* BKGD-W .75) ROW8) (make-posn BKGD-W ROW8)
                                 ; row 9 R
                                 (make-posn 0 ROW9) (make-posn (* BKGD-W .25) ROW9)
                                 (make-posn (* BKGD-W .5) ROW9) (make-posn (* BKGD-W .75) ROW9)
                                 ; row 10 L
                                 (make-posn (* BKGD-W .25) ROW10) (make-posn (* BKGD-W .5) ROW10)
                                 (make-posn (* BKGD-W .75) ROW10) (make-posn BKGD-W ROW10)
                                 ; row 11 R
                                 (make-posn 0 ROW11) (make-posn (* BKGD-W .25) ROW11)
                                 (make-posn (* BKGD-W .5) ROW11) (make-posn (* BKGD-W .75) ROW11)
                                 ; row 12 L
                                 (make-posn (* BKGD-W .25) ROW12) (make-posn (* BKGD-W .5) ROW12)
                                 (make-posn (* BKGD-W .75) ROW12) (make-posn BKGD-W ROW12)
                                 ; frog
                                 (make-posn HALF-BKGD-W ROW13))
                                BKGD))
 
;; a Player is a (make-posn Number Number)
;; represents the x and y coordinates of the player
(define PLAYER-START (make-posn HALF-BKGD-W ROW13))
(define PLAYER-MID (make-posn HALF-BKGD-W ROW10))
#;(define (player-templ p)
    (... (posn-x p) ...
         ... (posn-y p) ...))

;; a Direction is one of:
;; "left"
;; "right"
;; represents the direction a vehicle is moving
(define L "left")
(define R "right")
#;(define (dir-templ d)
    (cond
      [(string=? d R) ...]
      [(string=? d L) ...]))
 
;; a Vehicle is a (make-vehicle Number Number Direction)
(define-struct vehicle (x y dir))
;; represents the x and y coordinates of a vehicle and which direction it is moving
(define VEHICLE-10-L (make-vehicle HALF-BKGD-W ROW10 L))
(define VEHICLE-11-R (make-vehicle (+ BKGD-W HALF-CAR-W) ROW11 R))
#;(define (vehicle-templ v)
    (... (vehicle-x v) ...
         ... (vehicle-y v) ...
         ... (dir-templ (vehicle-dir v)) ...))
 
;; a SetOfVehicles (VSet) is one of:     
;; - empty     
;; - (cons Vehicle VSet)
;; represents a set of vehicles moving across the screen
(define VSET0 '())
(define VSET1 (list
               (make-vehicle (* BKGD-W .25) ROW8 L)
               (make-vehicle (* BKGD-W .5) ROW8 L)
               (make-vehicle (* BKGD-W .75) ROW8 L)
               (make-vehicle (- 0 HALF-CAR-W) ROW8 L)))
(define VSET-START (list
                    ; row 8
                    (make-vehicle (* BKGD-W .25) ROW8 L)
                    (make-vehicle (* BKGD-W .5) ROW8 L)
                    (make-vehicle (* BKGD-W .75) ROW8 L)
                    (make-vehicle BKGD-W ROW8 L)
                    ; row 9
                    (make-vehicle 0 ROW9 R)
                    (make-vehicle (* BKGD-W .25) ROW9 R)
                    (make-vehicle (* BKGD-W .5) ROW9 R)
                    (make-vehicle (* BKGD-W .75) ROW9 R)
                    ; row 10
                    (make-vehicle (* BKGD-W .25) ROW10 L)
                    (make-vehicle (* BKGD-W .5) ROW10 L)
                    (make-vehicle (* BKGD-W .75) ROW10 L)
                    (make-vehicle BKGD-W ROW10 L)
                    ; row 11
                    (make-vehicle 0 ROW11 R)
                    (make-vehicle (* BKGD-W .25) ROW11 R)
                    (make-vehicle (* BKGD-W .5) ROW11 R)
                    (make-vehicle (* BKGD-W .75) ROW11 R)
                    ; row 12
                    (make-vehicle (* BKGD-W .25) ROW12 L)
                    (make-vehicle (* BKGD-W .5) ROW12 L)
                    (make-vehicle (* BKGD-W .75) ROW12 L)
                    (make-vehicle BKGD-W ROW12 L)))
#;(define (vset-templ vset)
    (cond
      [(empty? vset) ...]
      [(cons? vset) ... (vehicle-templ (first vset)) ...
                    ... (vset-templ (rest vset)) ...]))

;; a Platform is a (make-platform Number Number Direction)
(define-struct platform [x y dir])
;; represents the x any y coordinates and the direction of a log or turtle
(define LOG-2-R (make-platform HALF-BKGD-W ROW2 R))
(define TURTLE-3-L (make-platform (- 0 HALF-TURTLE-W) ROW3 L))
#;(define (plat-templ plat)
  (... (platform-x plat) ...
         ... (platform-y plat) ...
         ... (dir-templ (platform-dir plat)) ...))

;; a SetOfPlatforms (PSet) is one of
;; empty
;; (cons Platform PSet)
;; represents a set of platforms moving across the screen
(define PSET0 '())
(define PSET1 (list
               (make-platform (* BKGD-W .25) ROW2 R)
               (make-platform (* BKGD-W .5) ROW2 R)
               (make-platform (* BKGD-W .75) ROW2 R)
               (make-platform (+ BKGD-W HALF-LOG-W) ROW2 R)))
(define PSET-START (list
                    ; row 2 R
                    (make-platform 0 ROW2 R)
                    (make-platform (* BKGD-W .25) ROW2 R)
                    (make-platform (* BKGD-W .5) ROW2 R)
                    (make-platform (* BKGD-W .75) ROW2 R)
                    ; row 3 L
                    (make-platform (* BKGD-W .25) ROW3 L)
                    (make-platform (* BKGD-W .5) ROW3 L)
                    (make-platform (* BKGD-W .75) ROW3 L)
                    (make-platform BKGD-W ROW3 L)
                    ; row 4 R
                    (make-platform 0 ROW4 R)
                    (make-platform (* BKGD-W .25) ROW4 R)
                    (make-platform (* BKGD-W .5) ROW4 R)
                    (make-platform (* BKGD-W .75) ROW4 R)
                    ; row 5 L
                    (make-platform (* BKGD-W .25) ROW5 L)
                    (make-platform (* BKGD-W .5) ROW5 L)
                    (make-platform (* BKGD-W .75) ROW5 L)
                    (make-platform BKGD-W ROW5 L)
                    ; row 6 R
                    (make-platform 0 ROW6 R)
                    (make-platform (* BKGD-W .25) ROW6 R)
                    (make-platform (* BKGD-W .5) ROW6 R)
                    (make-platform (* BKGD-W .75) ROW6 R)))
#;(define (pset-templ pset)
  (cond
      [(empty? pset) ...]
      [(cons? pset) ... (plat-templ (first pset)) ...
                    ... (pset-templ (rest pset)) ...]))
 
;; a World is a (make-world Player VSet PSet)
(define-struct world (player vehicles plats))
;; Player represents the position of the player
;; Vehicles represents the set of vehicles moving across the screen
;; Plats represents the set of platforms moving across the screen
(define START
  (make-world PLAYER-START VSET-START PSET-START))
(define FROG-SAFE
  (make-world (make-posn (* BKGD-W .375) ROW8) VSET1 PSET1))
(define FROG-HIT
  (make-world (make-posn (- (* BKGD-W .25) (+ HALF-FROG-W HALF-CAR-W)) ROW8) VSET1 PSET1))
(define FROG-FLOAT
  (make-world (make-posn (* BKGD-W .25) ROW2) VSET1 PSET1))
(define FROG-DROWN
  (make-world (make-posn (* BKGD-W .375) ROW2) VSET1 PSET1))
(define FROG-WIN
  (make-world (make-posn HALF-BKGD-W ROW1) VSET-START PSET-START))
#;(define (world-templ w)
    (... (player-templ (world-player w)) ...
         ... (vset-templ (world-vehicles w)) ...))

;; main: World -> World
;; launches Frogger
(define (main world0)
  (big-bang world0
    [to-draw draw-world]
    [on-tick tick-world]
    [on-key move-frog]
    [stop-when done? final-scene]))

;; draw-world: World -> Image
;; displays the world
(check-expect (draw-world START) START-IMG)
(define (draw-world w)
  (local [;; draw-player: Player Image -> Image
          ;; draws the player onto the given background
          (define (draw-player p bg)
            (place-image FROG (posn-x p) (posn-y p) bg))
          ;; draw-vehicle: Vehicle Image -> Image
          ;; draws the given vehicle onto the given background
          (define (draw-vehicle v bg)
            (place-image (if (string=? (vehicle-dir v) R) CAR-R CAR-L)
                         (vehicle-x v) (vehicle-y v) bg))
          ;; draw-plat: Platform Image -> Image
          ;; draws the given platform onto the given background
          (define (draw-plat plat bg)
            (place-image (if (string=? (platform-dir plat) R) LOG TURTLE)
                         (platform-x plat) (platform-y plat) bg))]
  (draw-player (world-player w)
               (foldr draw-vehicle (foldr draw-plat BKGD (world-plats w)) (world-vehicles w)))))

;; tick-world: World -> World
;; moves all vehicles
(check-expect (tick-world (make-world PLAYER-START VSET1 PSET1))
              (make-world PLAYER-START
                          (list
                           (make-vehicle (- (* BKGD-W .25) CAR-SPEED) ROW8 L)
                           (make-vehicle (- (* BKGD-W .5) CAR-SPEED) ROW8 L)
                           (make-vehicle (- (* BKGD-W .75) CAR-SPEED) ROW8 L)
                           (make-vehicle (+ BKGD-W HALF-CAR-W) ROW8 L))
                          (list
                           (make-platform (+ (* BKGD-W .25) PLAT-SPEED) ROW2 R)
                           (make-platform (+ (* BKGD-W .5) PLAT-SPEED) ROW2 R)
                           (make-platform (+ (* BKGD-W .75) PLAT-SPEED) ROW2 R)
                           (make-platform (- 0 HALF-LOG-W) ROW2 R))))
(check-expect (tick-world (make-world PLAYER-START '() '())) (make-world PLAYER-START '() '()))
(define (tick-world w)
  (make-world (world-player w) (tick-vehicles (world-vehicles w)) (tick-plats (world-plats w))))

;; tick-vehicles: VSet -> VSet
;; moves the vehicles in whichever direction they are facing
(check-expect (tick-vehicles VSET0) '())
(check-expect (tick-vehicles VSET1) (list
                                     (make-vehicle (- (* BKGD-W .25) CAR-SPEED) ROW8 L)
                                     (make-vehicle (- (* BKGD-W .5) CAR-SPEED) ROW8 L)
                                     (make-vehicle (- (* BKGD-W .75) CAR-SPEED) ROW8 L)
                                     (make-vehicle (+ BKGD-W HALF-CAR-W) ROW8 L)))
(check-expect (tick-vehicles (list (make-vehicle HALF-BKGD-W ROW11 R) VEHICLE-11-R))
              (list (make-vehicle (+ HALF-BKGD-W CAR-SPEED) ROW11 R)
                    (make-vehicle (- 0 HALF-CAR-W) ROW11 R)))
(define (tick-vehicles vset)
  (local [;; tick-1vehicle: Vehicle -> Vehicle
          ;; moves a vehicle in the direction it is facing
          (define (tick-1vehicle v)
            (cond
              [(string=? (vehicle-dir v) "left")
               (if ((λ(v) (<= (vehicle-x v) (- 0 HALF-CAR-W))) v)
                   (make-vehicle (+ BKGD-W HALF-CAR-W) (vehicle-y v) (vehicle-dir v))
                   (make-vehicle (- (vehicle-x v) CAR-SPEED) (vehicle-y v) (vehicle-dir v)))]
              [(string=? (vehicle-dir v) "right")
               (if ((λ(v) (>= (vehicle-x v) (+ BKGD-W HALF-CAR-W))) v)
                   (make-vehicle (- 0 HALF-CAR-W) (vehicle-y v) (vehicle-dir v))
                   (make-vehicle (+ (vehicle-x v) CAR-SPEED) (vehicle-y v) (vehicle-dir v)))]))]
    (map tick-1vehicle vset)))

;; tick-plats: VSet -> VSet
;; moves the vehicles in whichever direction they are facing
(check-expect (tick-plats PSET0) '())
(check-expect (tick-plats PSET1) (list
                                     (make-platform (+ (* BKGD-W .25) PLAT-SPEED) ROW2 R)
                                     (make-platform (+ (* BKGD-W .5) PLAT-SPEED) ROW2 R)
                                     (make-platform (+ (* BKGD-W .75) PLAT-SPEED) ROW2 R)
                                     (make-platform (- 0 HALF-LOG-W) ROW2 R)))
(check-expect (tick-plats (list (make-platform HALF-BKGD-W ROW2 R) TURTLE-3-L))
              (list (make-platform (+ HALF-BKGD-W PLAT-SPEED) ROW2 R)
                    (make-platform (+ BKGD-W HALF-TURTLE-W) ROW3 L)))
(define (tick-plats pset)
  (local [;; tick-1plat: Platform -> Platform
          ;; moves a platform in the direction it is facing
          (define (tick-1plat plat)
            (cond
              [(string=? (platform-dir plat) "left")
               (if ((λ(plat) (<= (platform-x plat) (- 0 HALF-TURTLE-W))) plat)
                   (make-platform
                    (+ BKGD-W HALF-TURTLE-W) (platform-y plat) (platform-dir plat))
                   (make-platform
                    (- (platform-x plat) PLAT-SPEED) (platform-y plat) (platform-dir plat)))]
              [(string=? (platform-dir plat) "right")
               (if ((λ(plat) (>= (platform-x plat) (+ BKGD-W HALF-LOG-W))) plat)
                   (make-platform
                    (- 0 HALF-LOG-W) (platform-y plat) (platform-dir plat))
                   (make-platform
                    (+ (platform-x plat) PLAT-SPEED) (platform-y plat) (platform-dir plat)))]))]
    (map tick-1plat pset)))

;; tick-player: Player -> Player
;; moves the player if they are on a platform
;(check-expect 

;; move-frog: World KeyEvent -> World
;; moves the frog when an arrow key is pressed
(check-expect (move-frog (make-world PLAYER-MID VSET1 PSET1) "up")
              (make-world (make-posn HALF-BKGD-W ROW9) VSET1 PSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1 PSET1) "down")
              (make-world (make-posn HALF-BKGD-W ROW11) VSET1 PSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1 PSET1) "left")
              (make-world (make-posn (- HALF-BKGD-W ROW) ROW10) VSET1 PSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1 PSET1) "right")
              (make-world (make-posn (+ HALF-BKGD-W ROW) ROW10) VSET1 PSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1 PSET1) "t")
              (make-world PLAYER-MID VSET1 PSET1))
(define (move-frog w a-key)
  (cond
    [(key=? a-key "up")
     (make-world
      (make-posn (posn-x (world-player w)) (- (posn-y (world-player w)) ROW))
      (world-vehicles w) (world-plats w))]
    [(key=? a-key "down")
     (make-world
      (make-posn (posn-x (world-player w)) (+ (posn-y (world-player w)) ROW))
      (world-vehicles w) (world-plats w))]
    [(key=? a-key "left")
     (make-world
      (make-posn (- (posn-x (world-player w)) ROW) (posn-y (world-player w)))
      (world-vehicles w) (world-plats w))]
    [(key=? a-key "right")
     (make-world
      (make-posn (+ (posn-x (world-player w)) ROW) (posn-y (world-player w)))
      (world-vehicles w) (world-plats w))]
    [else w]))

;; done?: World -> Boolean
;; determines whether the game is over
(check-expect (done? START) #f)
(check-expect (done? FROG-HIT) #t)
(check-expect (done? FROG-WIN) #t)
(define (done? w)
  (or (win? w) (lose? w)))

;; win?: World -> Boolean
;; determines whether the game has been won
(check-expect (win? START) #f)
(check-expect (win? FROG-WIN) #t)
(define (win? w)
  (= (posn-y (world-player w)) ROW1))

;; lose?: World -> Boolean
;; determines whether the player has been hit by a vehicle
(check-expect (lose? FROG-SAFE) #f)
(check-expect (lose? FROG-HIT) #t)
(define (lose? w)
  (any-touching? (world-player w) (world-vehicles w)))

;; touching?: Player Vehicle -> Boolean
;; determines whether the given player is toucing the given car
(check-expect (touching? (make-posn (* BKGD-W .375) ROW8) (make-vehicle (* BKGD-W .25) ROW8 L)) #f)
(check-expect (touching? (make-posn (- (* BKGD-W .25) (+ HALF-FROG-W HALF-CAR-W)) ROW8)
                         (make-vehicle (* BKGD-W .25) ROW8 L)) #t)
(define (touching? p v)
  (and
   (<= (abs (- (posn-x p) (vehicle-x v))) (+ HALF-CAR-W HALF-FROG-W))
   (<= (abs (- (posn-y p) (vehicle-y v))) (+ HALF-CAR-H HALF-FROG-H))))

;; any-touching?: Player VSet -> Boolean
;; determines whether any vehicles in a given set are touching the player
(check-expect (any-touching? (make-posn (* BKGD-W .375) ROW8) VSET1) #f)
(check-expect (any-touching? (make-posn (- (* BKGD-W .25) (+ HALF-FROG-W HALF-CAR-W)) ROW8) VSET1) #t)
(define (any-touching? p vset)
  (local [;; touching?: Player Vehicle -> Boolean
          ;; determines whether the given player is toucing the given car
          (define (touching? p v)
            (and
             (<= (abs (- (posn-x p) (vehicle-x v))) (+ HALF-CAR-W HALF-FROG-W))
             (<= (abs (- (posn-y p) (vehicle-y v))) (+ HALF-CAR-H HALF-FROG-H))))]
  (cond
    [(empty? vset) #f]
    [(cons? vset) (or (touching? p (first vset))
                      (any-touching? p (rest vset)))])))

;; on-plat?: Player Platform -> Boolean
;; determines whether the player is on the given platform
(check-expect (on-plat? (make-posn (* BKGD-W .375) ROW2) (make-platform (* BKGD-W .25) ROW2 R)) #f)
(check-expect (on-plat? (make-posn (* BKGD-W .25) ROW2) (make-platform (* BKGD-W .25) ROW2 R)) #t)
(define (on-plat? p plat)
   (cond
     [(string=? (platform-dir plat) "left")
      (and (<= (abs (- (posn-x p) (platform-x plat))) (+ HALF-TURTLE-W HALF-FROG-W))
           (<= (abs (- (posn-y p) (platform-y plat))) (+ HALF-TURTLE-H HALF-FROG-H)))]
     [(string=? (platform-dir plat) "right")
      (and (<= (abs (- (posn-x p) (platform-x plat))) (+ HALF-LOG-W HALF-FROG-W))
           (<= (abs (- (posn-y p) (platform-y plat))) (+ HALF-LOG-H HALF-FROG-H)))]))

;; on-any-plat: Player PSet -> Boolean

;; final-scene: World -> Image
;; displays the final scene
(check-expect (final-scene FROG-WIN) (overlay (text WIN-TXT TXT-SIZE "green") BKGD))
(check-expect (final-scene FROG-HIT) (overlay (text LOSE-TXT TXT-SIZE "red") BKGD))
(define (final-scene w)
  (cond
    [(win? w) (overlay (text WIN-TXT TXT-SIZE "green") BKGD)]
    [(lose? w) (overlay (text LOSE-TXT TXT-SIZE "red") BKGD)]))
