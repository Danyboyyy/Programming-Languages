-- ====================
-- Complete the following functions and submit your file to Canvas.
-- ====================
-- Do not change the names of the functions. 
-- Do not change the number of arguments in the functions.
-- If your file cannot be loaded by the Haskell compiler, your submission may be cancelled. 
-- Then, submit only code that works.
-- ====================
-- Grading instructions:
-- There is a series of test cases for each function. In order to state that your function
-- "works as described", your output must be similar to the expected one in each case.

-- === Distance between two points ===

data Point = Point Double Double deriving Show

distance :: Point -> Point -> Double
distance _ _ = error "Not yet implemented\n"

-- === Complex numbers ===

data Complex = Complex Int Int deriving Show

add :: Complex -> Complex -> Complex
add _ _ = error "Not yet implemented\n"

multiply :: Complex -> Int -> Complex
multiply _ _ = error "Not yet implemented\n"

getReal :: Complex -> Int
getReal _ = error "Not yet implemented\n"

getImaginary :: Complex -> Int
getImaginary _ = error "Not yet implemented\n"

-- === The RGB color mode ===

-- Yes, the components are given as a tuple inside the data type...
data RGB = RGB (Int, Int, Int) deriving Show

getR :: RGB -> Int
getR _ = error "Not yet implemented\n"

getG :: RGB -> Int
getG _ = error "Not yet implemented\n"

getB :: RGB -> Int
getB _ = error "Not yet implemented\n"

getMaxComponent :: RGB -> ([Char], Int)
getMaxComponent _ = error "Not yet implemented\n"

combine :: RGB -> RGB -> RGB
combine _ _  = error "Not yet implemented\n"

-- === Playing cards ===

data Suit = Diamonds | Clubs | Hearts | Spades deriving Show
data Color = Red | Black deriving Show
data Rank = Jack | Queen | King | Ace | Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten deriving Show
data Card = Card Rank Suit deriving Show

getValue :: Card -> Int
getValue _ = error "Not yet implemented\n"

getColor :: Card -> Color
getColor _ = error "Not yet implemented\n"

-- === Test cases ===

main = do 
    print "=== Distance between two points ==="
    print "=== distance ==="
    print $ distance (Point 10 20) (Point 5 15) -- 7.0710678118654755
    print "=== Complex numbers ==="
    print "=== add ==="
    print $ add (Complex 5 6) (Complex 10 2) -- Complex 15 8
    print "=== multiply ==="
    print $ multiply (Complex 3 4) 6 -- Complex 18 4
    print "=== getReal ==="
    print $ getReal (Complex 2 3) -- 2
    print "=== getImaginary ==="
    print $ getImaginary (Complex 2 3) -- 3
    print "=== The RGB color mode ==="
    print "=== getR ==="
    print $ getR (RGB (150, 30, 25)) -- 150
    print "=== getG ==="
    print $ getG (RGB (150, 30, 25)) -- 30
    print "=== getB ==="
    print $ getB (RGB (150, 30, 25)) -- 25
    print "=== getMaxComponent ==="
    print $ getMaxComponent (RGB (17, 78, 63)) -- ("Green", 78)
    print "=== combine ==="
    print $ combine (RGB (120, 120, 60)) (RGB (150, 70, 80)) -- RGB (135, 95, 70)
    print "=== Playing cards ==="
    print "=== getValue ==="
    print $ getValue (Card King Diamonds) -- 13
    print $ getValue (Card Three Spades) -- 3
    print "=== getColor ==="
    print $ getColor (Card King Diamonds) -- Red
    print $ getColor (Card Three Spades) -- Black
    