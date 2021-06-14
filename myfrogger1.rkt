;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname myfrogger1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Constants

(define PLAYERIMG (circle 25 "solid" "green"))
(define VEHICLEIMG (rectangle 50 50 "solid" "red"))
(define PLAYERRATE 100)
(define VEHICLERATE 30)
(define BGH 700)
(define BGW 800)
(define BG (empty-scene BGW BGH))
(define HALFBGH (/ BGH 2))
(define HALFBGW (/ BGW 2))
(define PLAYERRAD 25)
(define ENDROW 50)
(define ROAD5 150)
(define ROAD4 250)
(define ROAD3 350)
(define ROAD2 450)
(define ROAD1 550)
(define STARTROW 650)
(define COLUMN1 100)
(define COLUMN2 300)
(define COLUMN3 500)
(define COLUMN4 700)
                               
                             
; Data Definitions
 
; A Direction is one of: "left" | "right"
 
; A Player is a (make-player Number Number)
(define-struct player (x y))
;; represents the position of the player where
;; x represents a player's x position and
;; y represents the player's y position
(define PLAYER0 (make-player HALFBGW STARTROW))
(define (player-temp p)
  (... (player-x p)
       (player-y p) ...))
 
; A Vehicle is a (make-vehicle Number Number Direction)
(define-struct vehicle (x y dir))
;; represents the position of a vehicle where
;; x is the vehicle's x coordinate
;; y is the vehicle's y coordinate and
;; dir is the Direction of the vehicle
(define V1.1 (make-vehicle COLUMN1 ROAD1 "right"))
(define V1.2 (make-vehicle COLUMN2 ROAD1 "right"))
(define V1.3 (make-vehicle COLUMN3 ROAD1 "right"))
(define V1.4 (make-vehicle COLUMN4 ROAD1 "right"))

(define V2.1 (make-vehicle COLUMN1 ROAD2 "left"))
(define V2.2 (make-vehicle COLUMN2 ROAD2  "left"))
(define V2.3 (make-vehicle COLUMN3 ROAD2  "left"))
(define V2.4 (make-vehicle COLUMN4 ROAD2 "left"))

(define V3.1 (make-vehicle COLUMN1 ROAD3 "right"))
(define V3.2 (make-vehicle COLUMN2 ROAD3 "right"))
(define V3.3 (make-vehicle COLUMN3 ROAD3 "right"))
(define V3.4 (make-vehicle COLUMN4 ROAD3 "right"))

(define V4.1 (make-vehicle COLUMN1 ROAD4 "left"))
(define V4.2 (make-vehicle COLUMN2 ROAD4 "left"))
(define V4.3 (make-vehicle COLUMN3 ROAD4 "left"))
(define V4.4 (make-vehicle COLUMN4 ROAD4 "left"))

(define V5.1 (make-vehicle COLUMN1 ROAD5 "right"))
(define V5.2 (make-vehicle COLUMN2 ROAD5 "right"))
(define V5.3 (make-vehicle COLUMN3 ROAD5 "right"))
(define V5.4 (make-vehicle COLUMN4 ROAD5 "right"))

(define (vehicle-temp v)
  (... (vehicle-x v)
       (vehicle-y v)
       (vehicle-dir v) ...))
 
; A Set of Vehicles (VSet) is one of:     
; - empty     
; - (cons Vehicle VSet)
;; represents a set of vehicles
(define VSET0 (list V1.1 V1.2 V1.3 V1.4
                    V2.1 V2.2 V2.3 V2.4
                    V3.1 V3.2 V3.3 V3.4
                    V4.1 V4.2 V4.3 V4.4
                    V5.1 V5.2 V5.3 V5.4))
                    
#;(define (vset-temp vset)
    (cond [(empty? vset) ...]
          [(cons? vset) ... (first vset)
                        (vset-temp (rest vset)) ...]))

; A World is a (make-world Player VSet)
;; represents a World containing both a Player and a VSet
; The VSet represents the set of vehicles moving across the screen
(define-struct world (player vehicles))
(define WORLD0 (make-world PLAYER0 VSET0))
(define (world-temp w)
  (... (player-temp w)
       (vset-temp w) ...))


;; main: World -> World
;; starts the game
(define (main w0)
  (big-bang w0
    (to-draw draw-world)
    (on-tick world-tick)
    (on-key move-player)
    (stop-when game-over? end-scene)))

(define STARTIMG (place-image PLAYERIMG HALFBGW STARTROW
                              (place-images (list VEHICLEIMG VEHICLEIMG VEHICLEIMG VEHICLEIMG
                                                  VEHICLEIMG VEHICLEIMG VEHICLEIMG VEHICLEIMG
                                                  VEHICLEIMG VEHICLEIMG VEHICLEIMG VEHICLEIMG
                                                  VEHICLEIMG VEHICLEIMG VEHICLEIMG VEHICLEIMG
                                                  VEHICLEIMG VEHICLEIMG VEHICLEIMG VEHICLEIMG)
                                            (list (make-posn (vehicle-x V1.1) (vehicle-y V1.1))
                                                  (make-posn (vehicle-x V1.2) (vehicle-y V1.2))
                                                  (make-posn (vehicle-x V1.3) (vehicle-y V1.3))
                                                  (make-posn (vehicle-x V1.4) (vehicle-y V1.4))
                                                  (make-posn (vehicle-x V2.1) (vehicle-y V2.1))
                                                  (make-posn (vehicle-x V2.2) (vehicle-y V2.2))
                                                  (make-posn (vehicle-x V2.3) (vehicle-y V2.3))
                                                  (make-posn (vehicle-x V2.4) (vehicle-y V2.4))
                                                  (make-posn (vehicle-x V3.1) (vehicle-y V3.1))
                                                  (make-posn (vehicle-x V3.2) (vehicle-y V3.2))
                                                  (make-posn (vehicle-x V3.3) (vehicle-y V3.3))
                                                  (make-posn (vehicle-x V3.4) (vehicle-y V3.4))
                                                  (make-posn (vehicle-x V4.1) (vehicle-y V4.1))
                                                  (make-posn (vehicle-x V4.2) (vehicle-y V4.2))
                                                  (make-posn (vehicle-x V4.3) (vehicle-y V4.4))
                                                  (make-posn (vehicle-x V4.4) (vehicle-y V4.4))
                                                  (make-posn (vehicle-x V5.1) (vehicle-y V5.1))
                                                  (make-posn (vehicle-x V5.2) (vehicle-y V5.2))
                                                  (make-posn (vehicle-x V5.3) (vehicle-y V5.3))
                                                  (make-posn
                                                   (vehicle-x V5.4)
                                                   (vehicle-y V5.4)))        
                                            BG)))
;; draw-world: World -> Image
;; draws the world as a scene
(check-expect (draw-world WORLD0) STARTIMG)
(define (draw-world w)
  (draw-player (world-player w)
               ;; [Player Image -> Image] Image [List-of Vehicles] -> Image
               (foldr draw-vehicle BG (world-vehicles w))))

;; draw-player: Player Image -> Image
;; draws player onto a given background
(check-expect (draw-player PLAYER0 BG) (place-image PLAYERIMG HALFBGW STARTROW BG))
(define (draw-player p i)
  (place-image PLAYERIMG (player-x p) (player-y p) i))

;; draw-vehicle: Vehicle Image -> Image
;; draws a vehicle onto the given background
(check-expect (draw-vehicle V1.1 BG) (place-image VEHICLEIMG COLUMN1 ROAD1 BG))
(define (draw-vehicle v i)
  (place-image VEHICLEIMG (vehicle-x v) (vehicle-y v) i))



;; world-tick: World -> World
;; creates the next world state by moving all of the vehicles left or right
(check-expect (world-tick (make-world
                           PLAYER0
                           (list (make-vehicle 0 ROAD1 "left")
                                 (make-vehicle 800 ROAD2 "right")
                                 (make-vehicle 300 ROAD3 "left")
                                 (make-vehicle 400 ROAD4 "right"))))
              (make-world
               PLAYER0
               (list (make-vehicle 799 ROAD1 "left")
                     (make-vehicle 1 ROAD2 "right")
                     (make-vehicle 299 ROAD3 "left")
                     (make-vehicle 401 ROAD4 "right"))))
(check-expect (world-tick (make-world
                           PLAYER0
                           (list (make-vehicle 300 ROAD3 "left")
                                 (make-vehicle 400 ROAD4 "right"))))
              (make-world
               PLAYER0
               (list (make-vehicle 299 ROAD3 "left")
                     (make-vehicle 401 ROAD4 "right"))))        
(define (world-tick w)
  (if (vehicle-edge? (world-vehicles w))
      (make-world (world-player w) (move-vehicles (add-vehicle (world-vehicles w))))
      (make-world (world-player w) (move-vehicles (world-vehicles w)))))


(define VSETSHORT (list V1.1 V1.2 V2.1)) 
;; move-vehicles: VSet -> VSet
;; moves all of the vehicles in a set
(check-expect (move-vehicles VSETSHORT) (list (make-vehicle (+ 1 COLUMN1) ROAD1 "right")
                                              (make-vehicle (+ 1 COLUMN2) ROAD1 "right")
                                              (make-vehicle (- COLUMN1 1) ROAD2 "left")))
(define (move-vehicles v)
  ;; [Vehicle Vehicle] [VSet -> Vset] [List-of Vehicle] -> [List-of Vehicle]
  (map move-vehicle v)) 

;; move-vehicle: Vehicle -> Vehicle
;; shifts a vehicle left or right depending on its direction
(check-expect (move-vehicle V1.1) (make-vehicle (+ 1 COLUMN1) ROAD1 "right"))
(check-expect (move-vehicle V2.1) (make-vehicle (- COLUMN1 1) ROAD2 "left"))
(define (move-vehicle v)
  (if (string=? (vehicle-dir v) "right")
      (make-vehicle (+ 1 (vehicle-x v)) (vehicle-y v) (vehicle-dir v))
      (make-vehicle (- (vehicle-x v) 1) (vehicle-y v) (vehicle-dir v))))


;; vehicle-edge? VSet -> Boolean
;; determines if a vehicle is moving off screen
(check-expect (vehicle-edge? (list (make-vehicle 0 83 "left")
                                   (make-vehicle 485 83 "right")
                                   (make-vehicle 249 141 "left"))) #t)
(check-expect (vehicle-edge? (list (make-vehicle 800 ROAD2 "right")
                                   (make-vehicle 431 ROAD1 "left")
                                   (make-vehicle 201 ROAD2 "right"))) #t)
(check-expect (vehicle-edge? (list (make-vehicle 800 ROAD2 "right")
                                   (make-vehicle 0 ROAD1 "left")
                                   (make-vehicle 195 ROAD3 "left"))) #t)
(check-expect (vehicle-edge? (list (make-vehicle 400 ROAD2 "right")
                                   (make-vehicle 300 ROAD1 "left")
                                   (make-vehicle 195 ROAD3 "left"))) #f)
(define (vehicle-edge? vs)
  (cond [(empty? vs) #f]
        [(cons? vs) (cond [(and (= 0 (vehicle-x (first vs)))
                                (string=? "left" (vehicle-dir (first vs)))) #t]
                          [(and
                            (= 800
                               (vehicle-x
                                (first vs)))
                            (string=? "right" (vehicle-dir (first vs)))) #t]
                          [else
                           (vehicle-edge?
                            (rest vs))])]))                                                     

;; add-vehicle: VSet -> VSet
;; adds a vehicle to a vset
(check-expect (add-vehicle (list (make-vehicle 0 83 "left")
                                 (make-vehicle 485 83 "right")
                                 (make-vehicle 249 141 "left")))
              (list (make-vehicle 800 83 "left") 
                    (make-vehicle 485 83 "right") 
                    (make-vehicle 249 141 "left")))
(check-expect (add-vehicle (list (make-vehicle 800 ROAD2 "right")
                                 (make-vehicle 431 ROAD1 "left")
                                 (make-vehicle 201 ROAD2 "right")))
              (list (make-vehicle 0 ROAD2 "right") 
                    (make-vehicle 431 ROAD1 "left") 
                    (make-vehicle 201 ROAD2 "right")))

(check-expect (add-vehicle (list (make-vehicle 800 ROAD2 "right")
                                 (make-vehicle 0 ROAD1 "left")
                                 (make-vehicle 195 ROAD3 "left")))
              (list (make-vehicle 0 ROAD2 "right") 
                    (make-vehicle 800 ROAD1 "left") 
                    (make-vehicle 195 ROAD3 "left")))
(define (add-vehicle vs)
  (cond
    [(empty? vs) empty]
    [(and (= 0 (vehicle-x (first vs)))
          (string=? "left" (vehicle-dir (first vs))))
     (cons (make-vehicle 800 (vehicle-y (first vs)) "left")
           (add-vehicle (rest vs)))]
    [(and (= 800 (vehicle-x (first vs)))
          (string=? "right" (vehicle-dir (first vs))))
     (cons (make-vehicle 0 (vehicle-y (first vs)) "right")
           (add-vehicle (rest vs)))]
    [else (cons (first vs) (add-vehicle (rest vs)))]))


;; move-player: World String -> World
;; moves the player in the direction of the key pressed
(check-expect (move-player (make-world PLAYER0 empty) "up")
              (make-world (make-player HALFBGW (- STARTROW 100)) empty))
(check-expect (move-player (make-world PLAYER0 empty) "down")
              (make-world (make-player HALFBGW (+ STARTROW 100)) empty))
(check-expect (move-player (make-world PLAYER0 empty) "left")
              (make-world (make-player (- HALFBGW 50) STARTROW) empty))
(check-expect (move-player (make-world PLAYER0 empty) "right")
              (make-world (make-player (+ HALFBGW 50) STARTROW) empty))
(check-expect (move-player (make-world (make-player BGW ROAD1)  empty) "right")
              (make-world (make-player BGW ROAD1) empty))
(check-expect (move-player (make-world PLAYER0 empty) " ")
              (make-world PLAYER0 empty))
(define (move-player w a-key)
  (if (or (<= (player-x (world-player w)) 50) (>= (player-x (world-player w)) 750))
      (make-world (world-player w) (world-vehicles w))
      (cond [(key=? a-key "up")
             (make-world (make-player
                          (player-x (world-player w))
                          (- (player-y (world-player w)) 100))
                         (world-vehicles w))]
            [(key=? a-key "down")
             (make-world
              (make-player (player-x (world-player w)) (+ (player-y (world-player w)) 100))
              (world-vehicles w))]
            [(key=? a-key "left")
             (make-world
              (make-player (- (player-x (world-player w)) 50)  (player-y (world-player w)))
              (world-vehicles w))]
            [(key=? a-key "right")
             (make-world
              (make-player (+ (player-x (world-player w)) 50) (player-y (world-player w)))
              (world-vehicles w))]
            [else (make-world (world-player w) (world-vehicles w))])))


;; game-over?: World -> Boolean
;; ends the game if the player collides with a vehicle or
;; the player reaches the end of the board
(check-expect (game-over? WORLD0) #f)
(check-expect (game-over? (make-world (make-player COLUMN1 ENDROW) empty)) #t)
(check-expect (game-over? (make-world (make-player COLUMN1 ROAD1) VSET0)) #t)
(define (game-over? w)
  (or (won? w) (lost? w)))
  

;; lost?: World -> Boolean
;; determines if the player collided with a vehicle
(check-expect (lost? (make-world (make-player COLUMN1 ROAD1) VSET0)) #t)
(check-expect (lost? (make-world (make-player 250 ROAD1) VSET0)) #f)
(define (lost? w)
  (cond [(empty? (world-vehicles w)) #f]
        [(cons? (world-vehicles w)) (if (and
                                         (<
                                          (abs (- (player-x (world-player w))
                                                  (vehicle-x (first (world-vehicles w))))) 50)
                                         (<
                                          (abs (- (player-y (world-player w))
                                                  (vehicle-y (first (world-vehicles w))))) 50))
                                        #t
                                        (lost?
                                         (make-world
                                          (world-player w) (rest (world-vehicles w)))))]))



;; won?: World -> Boolean
;; determines if the player won by crossing all lanes of traffic
(check-expect (won? WORLD0) #f)
(check-expect (won? (make-world
                     (make-player COLUMN1 ENDROW)
                     empty)) #t)
(define (won? w)
  (= (player-y (world-player w)) ENDROW))



;; end-scene: World -> Image
;; displays an ending text at the end of the game
(check-expect (end-scene (make-world (make-player 250 ENDROW) empty))
              (place-image (text "YOU WON!" 40 "blue") 400 373
                           (place-image PLAYERIMG
                                        250 ENDROW
                                        BG)))
(check-expect (end-scene (make-world (make-player 250 100) empty))
              (place-image (text "GAME OVER. YOU LOST" 40 "black") 400 373
                           (place-image PLAYERIMG
                                        250 100
                                        BG)))
(define (end-scene w)
  (cond [(= (player-y (world-player w)) ENDROW)
         (place-image 
          (text "YOU WON!" 40 "blue") 
          400 373 (draw-world w))]
        [else 
         (place-image 
          (text "GAME OVER. YOU LOST" 40 "black") 
          400 373 (draw-world w))]))  
