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

-- === minusIndex ===

minusIndex :: [Int] -> [Int]
minusIndex lst = map (\(x, y) -> x - y) $ zip lst [0..(length lst)]

-- === evenList ===

evenList :: [Int] -> [(Int, Bool)]
evenList lst = map (\x -> (x, even x)) lst

-- === rotate ===

transpose :: [[Int]] -> [[Int]]
transpose ([]:_) = []
transpose m = (map head m) : transpose (map tail m)

rotateAux :: [[Int]] -> [[Int]]
rotateAux [] = []
rotateAux (h : t) = (reverse h) : (rotateAux t)

rotate :: [[Int]] -> [[Int]]
rotate m = rotateAux $ transpose m

-- === distance ===

distance :: [(Char, Char, Int)] -> [(Char, Char)] -> Int
distance graph path = foldl1 (+) $ map (\(x, y, z) -> z) pathExt
    where
        pathExt = map (\(x, y) -> head (filter (\(a, b, _) -> (x, y) == (a, b)) graph)) path

-- === pass ===

data Record = Record Int Double Double Double deriving Show

pass :: Int -> [Record] -> Bool
pass id table = let
    record = filter (\(Record idx x y z) -> id == idx) table
    in
    (\(Record _ x y z) -> ((x + y + z) / 3) >= 70) (head record)

-- === tSort ===

data Grade = Grade Int Int deriving Show

tSort :: [Grade] -> [Grade]
tSort [] = []
tSort ((Grade fid fgrade):rest) = let 
    leftList = filter (\(Grade _ grade) -> grade >= fgrade) rest
    rightList = filter (\(Grade _ grade) -> grade < fgrade) rest    
    in
    (tSort leftList) ++ [(Grade fid fgrade)] ++ (tSort rightList)

-- === apply ===
apply :: (a -> a -> a) -> [a] -> a
apply f [x, y] = f x y
apply f (h1 : h2 : t) = apply f ((f h1 h2) : t)
apply _ _ = error "apply requires a list with at least two elements.\n"

-- === Test cases ===

main = do
    print "=== minusIndex ==="
    print $ minusIndex [10, 20, 30, 40, 50] -- [10,19,28,37,46]
    print $ minusIndex [3, -8, 2, 6, 4] -- [3,-9,0,3,0]
    print "=== evenList ==="
    print $ evenList [6, 7, 3, 6, 14, 25, 10] -- [(6,True),(7,False),(3,False),(6,True),(14,True),(25,False),(10,True)]
    print $ evenList [1, 2, 3] -- [(1,False),(2,True),(3,False)]
    print "=== rotate ==="
    print $ rotate [[1, 2, 3], [4, 5, 6], [7, 8, 9]] -- [[7,4,1],[8,5,2],[9,6,3]]
    print $ rotate [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]] -- [[10,7,4,1],[11,8,5,2],[12,9,6,3]]
    print $ rotate [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]] -- [[9,7,5,3,1],[10,8,6,4,2]]
    print "=== distance ==="
    print $ distance [('a', 'c', 5), ('b', 'e', 8), ('c', 'b', 3), ('c', 'd', 8), ('d', 'e', 2), ('e', 'c', 6), ('e', 'f', 7)] [('a', 'c'), ('c', 'b'), ('b', 'e'), ('e', 'f')] -- 23
    print $ distance [('a', 'c', 5), ('b', 'e', 8), ('c', 'b', 3), ('c', 'd', 8), ('d', 'e', 2), ('e', 'c', 6), ('e', 'f', 7)] [('a', 'c'), ('c', 'd'), ('d', 'e'), ('e', 'c'), ('c', 'b'), ('b', 'e'), ('e', 'f')] -- 39
    print $ distance [('a', 'c', 5), ('b', 'e', 8), ('c', 'b', 3), ('c', 'd', 8), ('d', 'e', 2), ('e', 'c', 6), ('e', 'f', 7)] [('c', 'b'), ('b', 'e')] -- 11
    print "=== pass ==="
    print $ pass 791313 [(Record 796623 62 84 91), (Record 782544 81 89 77), (Record 790256 59 62 63), (Record 799610 75 68 82), (Record 791313 85 56 92), (Record 786621 98 97 92), (Record 809706 91 72 80)] -- True
    print $ pass 790256 [(Record 796623 62 84 91), (Record 782544 81 89 77), (Record 790256 59 62 63), (Record 799610 75 68 82), (Record 791313 85 56 92), (Record 786621 98 97 92), (Record 809706 91 72 80)] -- False
    print $ pass 782544 [(Record 796623 62 84 91), (Record 782544 81 89 77), (Record 790256 59 62 63), (Record 799610 75 68 82), (Record 791313 85 56 92), (Record 786621 98 97 92), (Record 809706 91 72 80)] -- True
    print $ "=== tSort ==="
    print $ tSort [(Grade 796623 92), (Grade 782544 83), (Grade 790256 62), (Grade 799610 75), (Grade 791313 85), (Grade 786621 98), (Grade 809706 94)] -- [Grade 786621 98,Grade 809706 94,Grade 796623 92,Grade 791313 85,Grade 782544 83,Grade 799610 75,Grade 790256 62]
    print $ "=== apply ==="
    print $ apply (+) [1, 2, 3, 4, 5] -- 15
    print $ apply (\x y -> if x >= y then x else y) [3, 5, 2, 9, 6, 6, 8, 1] -- 9
    print $ apply (\x y -> x ++ y) ["ab", "cd", "ef", "gh"] -- "abcdefgh"
    print $ apply (-) [1] -- *** Exception: apply requires a list with at least two elements.