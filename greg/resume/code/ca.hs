#!/usr/local/bin/runhugs

module Main where
main = do putStr "Enter your starting CA: "
          x <- getLine
          (sequence_ (map printCa (ca (stringToCa x))))

-- The simplest way to use this is to define your truth table and the value you
-- want to use for edge cases here.

-- If you're feeling a bit more adventurous, you can redefine the ruleset to
-- make more complex rules.

rule :: Bool -> Bool -> Bool -> Bool
rule    False   False   False = False
rule    False   False   True  = True
rule    False   True    False = True
rule    False   True    True  = True
rule    True    False   False = True
rule    True    False   True  = True
rule    True    True    False = True
rule    True    True    True  = False

edgevalue :: Bool
edgevalue = False

ruleset :: [Bool] -> Bool
ruleset (y:[])     = ruleset [edgevalue,y,edgevalue]
ruleset (x:y:[])   = ruleset [x,y,edgevalue]
ruleset (x:y:z:ls) = rule x y z
-- an example ruleset that mimics the initial truthtable
-- ruleset (x:y:z:ls) = (x || y || z) && ((x && y && z) /= True)

-- ===========================
-- DO NOT EDIT BELOW HERE

ca   :: [Bool] -> [[Bool]]
ca x = x : (ca (next x))

next :: [Bool]   -> [Bool] -- special handling for the first item
next    []       = []
next    (x:[])   = [(ruleset [x])]
next    (x:y:ls) = (ruleset [x,y]) : (nextRemainder (x:y:ls))

nextRemainder :: [Bool]     -> [Bool]
nextRemainder    (y:z:[])   = [(ruleset [y,z])]
nextRemainder    (x:y:z:ls) = (ruleset [x,y,z]) : (nextRemainder (y:z:ls))

-- ===========================
-- IO handling

printCa :: [Bool] -> IO ()
printCa    x      = do putStr (caToString x)
                       putChar '\n'

caToString :: [Bool] -> String
caToString    ls     = map cellToChar ls

stringToCa :: String -> [Bool]
stringToCa    ls     = map charToCell ls

cellToChar :: Bool  -> Char
cellToChar    True  = '#'
cellToChar    False = '.'

charToCell :: Char -> Bool
charToCell    '#'  = True
charToCell    x    = False -- lenient input
