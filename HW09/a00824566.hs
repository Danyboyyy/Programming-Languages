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

-- === invert ===

invert :: [t] -> [t]
invert [] = []
invert lst = last lst : invert (init lst)

-- === or ===

listor :: [Int] -> [Int] -> [Int]
listor [] [] = []
listor (a : b) (x : y) = if a == x
 then if a == 0
 then 0 : listor b y
 else 1 : listor b y
 else 1 : listor b y

-- === multiples ===

multiples :: [Int] -> Int -> [Int]
multiples [] _ = []
multiples (a : b) x = if mod a x == 0
 then a : multiples b x
 else multiples b x

-- === differences ===

diff :: Int -> [Int] -> [Int]
diff _ [] = []
diff x (a : b) = if null b
 then abs(x - a) : diff x b
 else abs(a - head b) : diff x b

differences :: [Int] -> [Int]
differences lst = diff (head lst) lst

-- === toBinaryString ===

toBin :: Int -> [Char]
toBin 0 = ['0']
toBin 1 = ['1']
toBin x = if mod x 2 == 1
 then '1' : toBin(div x 2)
 else '0' : toBin(div x 2)

toBinaryString :: Int -> [Char]
toBinaryString lst = reverse(toBin lst)

-- === modulo ===

modulo :: Int -> Int -> Int
modulo 0 _ = 0 
modulo x y = let w = x - y in if w >= y
 then modulo w y
 else w

-- === evaluate ===

evaluate :: [Double] -> Double -> Double
evaluate [] _ = 0
evaluate (a : b) x = let y = length b in a * x ^^ y + evaluate b x 

-- === cleanString ===

unique :: Char -> [Char] -> [Char]
unique _ [] = []
unique c (a : b) = if c /= a
 then a : unique a b
 else unique a b

cleanString :: [Char] -> [Char]
cleanString [] = []
cleanString (a : b) = a : unique a b

-- === iSort ===

insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (a : b) = if x < a
 then x : a : b
 else a : (insert x b)

iSort :: [Int] -> [Int]
iSort [] = []
iSort (a : b) = insert a (iSort b)

-- === Test cases ===

main = do 
    print "=== invert ==="
    print $ invert ([] :: [Int])-- []
    print $ invert [1, 2, 3, 4, 5] -- [5,4,3,2,1]
    print $ invert "hello world!" -- "!dlrow olleh"
    print "=== listor ==="
    print $ listor [1, 1, 0] [0, 1, 0] -- [1,1,0]
    print $ listor [1, 0, 1, 0] [0, 0, 1, 1] -- [1,0,1,1]
    print $ listor [1, 0, 1, 0, 1] [1, 1, 1, 0, 0] -- [1,1,1,0,1]
    print "=== multiples ==="
    print $ multiples [2, 4, 5, 6] 2 -- [2,4,6]
    print $ multiples [9, 27, 8, 15, 4] 3 -- [9,27,15]
    print $ multiples [9, 8, 17, 5] 6 -- []
    print "=== differences ==="
    print $ differences [1, 2, 4, 8, 20] -- [1,2,4,12,19]
    print $ differences [5, 9, 13, 27, 100, 91, 4] -- [4,4,14,73,9,87,1]
    print $ differences [99] -- [0]
    print $ differences [] -- [] 
    print "=== toBinaryString ==="
    print $ toBinaryString 0 -- "0"
    print $ toBinaryString 1 -- "1"
    print $ toBinaryString 7 -- "111"
    print $ toBinaryString 32 -- "100000"
    print $ toBinaryString 1024 -- "10000000000"
    print "=== modulo ==="
    print $ modulo 10 2 -- 0
    print $ modulo 15 4 -- 3
    print $ modulo 20 9 -- 2
    print $ modulo 77 10 -- 7
    print "=== evaluate ==="
    print $ evaluate ([] :: [Double]) 100 -- 0.0
    print $ evaluate [2, 3.1, 10, 0] 2 -- 48.4
    print $ evaluate [10, 0] 2 -- 20.0
    print $ evaluate [1, 2, 3, 4, 5] 3 -- 179.0
    print "=== cleanString ==="
    print $ cleanString ([] :: String) -- ""
    print $ cleanString "yyzzza" -- "yza"
    print $ cleanString "aaaabbbccd" -- "abcd"
    print "=== iSort ==="
    print $ iSort [] -- []
    print $ iSort [1] -- [1]
    print $ iSort [1, 6, 3, 10, 2, 14] -- [1,2,3,6,10,14]