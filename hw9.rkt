;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw9) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/image)
(require 2htdp/universe)
(define FROG .)
(define HALF-FROG-W (/ (image-width FROG) 2))
(define HALF-FROG-H (/ (image-height FROG) 2))
(define SKULL .)
(define CAR-L .)
(define CAR-R .)
(define LOG .)
(define TURTLE .)
(define HALF-CAR-W (/ (image-width CAR-L) 2))
(define HALF-CAR-H (/ (image-height CAR-L) 2))
(define CAR-SPEED 3)
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
(define LINE (rectangle BKGD-W 3 "solid" "light goldenrod"))
(define BKGD (place-images
              (list LINE LINE LINE LINE)
              (list (make-posn HALF-BKGD-W (* ROW 8))
                    (make-posn HALF-BKGD-W (* ROW 9))
                    (make-posn HALF-BKGD-W (* ROW 10))
                    (make-posn HALF-BKGD-W (* ROW 11)))
              (overlay/align "middle" "top" GRASS
                             (overlay/align "middle" "bottom" GRASS
                                            (place-image GRASS HALF-BKGD-W ROW7
                                                         (rectangle BKGD-W BKGD-H "solid" BKGD-COLOR)))))
(define START-IMG (place-images (list
                                 CAR-L CAR-L CAR-L CAR-L
                                 CAR-R CAR-R CAR-R CAR-R
                                 CAR-L CAR-L CAR-L CAR-L
                                 CAR-R CAR-R CAR-R CAR-R
                                 CAR-L CAR-L CAR-L CAR-L
                                 FROG)
                                (list
                                 ; row 8 R
                                 (make-posn (* BKGD-W .25) ROW8) (make-posn (* BKGD-W .5) ROW8)
                                 (make-posn (* BKGD-W .75) ROW8) (make-posn BKGD-W ROW8)
                                 ; row 9 L
                                 (make-posn 0 ROW9) (make-posn (* BKGD-W .25) ROW9)
                                 (make-posn (* BKGD-W .5) ROW9) (make-posn (* BKGD-W .75) ROW9)
                                 ; row 10 R
                                 (make-posn (* BKGD-W .25) ROW10) (make-posn (* BKGD-W .5) ROW10)
                                 (make-posn (* BKGD-W .75) ROW10) (make-posn BKGD-W ROW10)
                                 ; row 11 L
                                 (make-posn 0 ROW11) (make-posn (* BKGD-W .25) ROW11)
                                 (make-posn (* BKGD-W .5) ROW11) (make-posn (* BKGD-W .75) ROW11)
                                 ; row 12 R
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
 
;; a SetofVehicles (VSet) is one of:     
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
 
;; a World is a (make-world Player VSet)
(define-struct world (player vehicles))
;; Player represents the position of the player
;; VSet represents the set of vehicles moving across the screen
(define START (make-world PLAYER-START VSET-START))
(define FROG-SAFE (make-world (make-posn (* BKGD-W .375) ROW8) VSET1))
(define FROG-HIT (make-world (make-posn (- (* BKGD-W .25) (+ HALF-FROG-W HALF-CAR-W)) ROW8) VSET1))
(define FROG-WIN (make-world (make-posn HALF-BKGD-W ROW1) VSET-START))
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
  (draw-player (world-player w)
               ; [Player Image -> Image] Image [List-of Vehicles] -> Image
               (foldr draw-vehicle BKGD (world-vehicles w))))

;; draw-player: Player Image -> Image
;; draws the player onto the given background
(check-expect (draw-player PLAYER-START BKGD) (place-image FROG HALF-BKGD-W ROW13 BKGD))
(define (draw-player p bg)
  (place-image FROG (posn-x p) (posn-y p) bg))

;; draw-dead: Player Image -> Image
;; draws a skull onto the given background in place of the player
(check-expect (draw-dead PLAYER-START BKGD) (place-image SKULL HALF-BKGD-W ROW13 BKGD))
(define (draw-dead p bg)
  (place-image SKULL (posn-x p) (posn-y p) bg))

;; draw-vehicle: Vehicle Image -> Image
;; draws the given vehicle onto the given background
(check-expect (draw-vehicle VEHICLE-10-L BKGD) (place-image CAR-L HALF-BKGD-W ROW10 BKGD))
(define (draw-vehicle v bg)
  (place-image (if (string=? (vehicle-dir v) "right") CAR-R CAR-L) (vehicle-x v) (vehicle-y v) bg))
  
;; tick-world: World -> World
;; moves all vehicles
(check-expect (tick-world (make-world PLAYER-START VSET1))
              (make-world PLAYER-START (list
                                        (make-vehicle (- (* BKGD-W .25) CAR-SPEED) ROW8 L)
                                        (make-vehicle (- (* BKGD-W .5) CAR-SPEED) ROW8 L)
                                        (make-vehicle (- (* BKGD-W .75) CAR-SPEED) ROW8 L)
                                        (make-vehicle (+ BKGD-W HALF-CAR-W) ROW8 L))))
(define (tick-world w)
  (make-world (world-player w) (tick-vehicles (world-vehicles w))))

;; tick-vehicles: VSet -> VSet
;; moves the vehicles in whichever direction they are facing
(check-expect (tick-vehicles VSET0) '())
(check-expect (tick-vehicles VSET1) (list
                                     (make-vehicle (- (* BKGD-W .25) CAR-SPEED) ROW8 L)
                                     (make-vehicle (- (* BKGD-W .5) CAR-SPEED) ROW8 L)
                                     (make-vehicle (- (* BKGD-W .75) CAR-SPEED) ROW8 L)
                                     (make-vehicle (+ BKGD-W HALF-CAR-W) ROW8 L)))
(define (tick-vehicles vset)
  (cond
    [(empty? vset) '()]
    [(cons? vset) (cons (tick-1vehicle (first vset))
                        (tick-vehicles (rest vset)))]))

;; tick-1vehicle: Vehicle -> Vehicle
;; moves a vehicle in the direction it is facing
(check-expect (tick-1vehicle VEHICLE-10-L) (make-vehicle (- HALF-BKGD-W CAR-SPEED) ROW10 L))
(check-expect (tick-1vehicle VEHICLE-11-R) (make-vehicle (- 0 HALF-CAR-W) ROW11 R))
(check-expect (tick-1vehicle (make-vehicle HALF-BKGD-W ROW9 R))
              (make-vehicle (+ HALF-BKGD-W CAR-SPEED) ROW9 R))
(define (tick-1vehicle v)
  (cond
    [(string=? (vehicle-dir v) "left")
     (if (edge? v)
         (make-vehicle (+ BKGD-W HALF-CAR-W) (vehicle-y v) (vehicle-dir v))
         (make-vehicle (- (vehicle-x v) CAR-SPEED) (vehicle-y v) (vehicle-dir v)))]
    [(string=? (vehicle-dir v) "right")
     (if (edge? v)
         (make-vehicle (- 0 HALF-CAR-W) (vehicle-y v) (vehicle-dir v))
         (make-vehicle (+ (vehicle-x v) CAR-SPEED) (vehicle-y v) (vehicle-dir v)))]))

;; edge?: Vehicle -> Boolean
;; determines whether a vehicle has reached the edge of the screen
(check-expect (edge? VEHICLE-11-R) #t)
(check-expect (edge? VEHICLE-10-L) #f)
(define (edge? v)
  (cond
    [(string=? (vehicle-dir v) "left") (<= (vehicle-x v) (- 0 HALF-CAR-W))]
    [(string=? (vehicle-dir v) "right") (>= (vehicle-x v) (+ BKGD-W HALF-CAR-W))]))

;; move-frog: World KeyEvent -> World
;; moves the frog when an arrow key is pressed
(check-expect (move-frog (make-world PLAYER-MID VSET1) "up")
              (make-world (make-posn HALF-BKGD-W ROW9) VSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1) "down")
              (make-world (make-posn HALF-BKGD-W ROW11) VSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1) "left")
              (make-world (make-posn (- HALF-BKGD-W ROW) ROW10) VSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1) "right")
              (make-world (make-posn (+ HALF-BKGD-W ROW) ROW10) VSET1))
(check-expect (move-frog (make-world PLAYER-MID VSET1) "t")
              (make-world PLAYER-MID VSET1))
(define (move-frog w a-key)
  (cond
    [(key=? a-key "up")
     (make-world
      (make-posn (posn-x (world-player w)) (- (posn-y (world-player w)) ROW))
      (world-vehicles w))]
    [(key=? a-key "down")
     (make-world
      (make-posn (posn-x (world-player w)) (+ (posn-y (world-player w)) ROW))
      (world-vehicles w))]
    [(key=? a-key "left")
     (make-world
      (make-posn (- (posn-x (world-player w)) ROW) (posn-y (world-player w)))
      (world-vehicles w))]
    [(key=? a-key "right")
     (make-world
      (make-posn (+ (posn-x (world-player w)) ROW) (posn-y (world-player w)))
      (world-vehicles w))]
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
  (cond
    [(empty? vset) #f]
    [(cons? vset) (or
                   (touching? p (first vset))
                   (any-touching? p (rest vset)))]))

;; final-scene: World -> Image
;; displays the final scene
(check-expect (final-scene FROG-WIN) (overlay (text WIN-TXT TXT-SIZE "green") (draw-world FROG-WIN)))
(check-expect (final-scene FROG-HIT) (overlay (text LOSE-TXT TXT-SIZE "red") (draw-lose FROG-HIT)))
(define (final-scene w)
  (cond
    [(win? w) (overlay (text WIN-TXT TXT-SIZE "green") (draw-world w))]
    [(lose? w) (overlay (text LOSE-TXT TXT-SIZE "red") (draw-lose w))]))

;; draw-lose: World -> Image
;; draws the losing image
(check-expect (draw-lose FROG-HIT)
              (draw-dead (make-posn (- (* BKGD-W .25) (+ HALF-FROG-W HALF-CAR-W)) ROW8)
                         (foldr draw-vehicle BKGD VSET1)))
(define (draw-lose w)
  (draw-dead (world-player w)
             ; [Player Image -> Image] Image [List-of Vehicles] -> Image
             (foldr draw-vehicle BKGD (world-vehicles w))))
