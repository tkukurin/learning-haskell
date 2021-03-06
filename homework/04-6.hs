
-- RPN to result

import Data.Char

type Operators = [ (Char, Int -> Int -> Int) ]

basic :: Operators
basic = [ ('+', (+)), ('-', (-)) ]

standard :: Operators
standard = [ ('+', (+)),
             ('-', (-)),
             ('*', (*)),
             ('/', div),
             ('^', (^)) ]


pop2push :: [Int] -> (Int -> Int -> Int) -> [Int]
pop2push (a:b:stack) operator = (operator b a):stack


rpnCalc :: String -> Operators -> Int
rpnCalc rpn operators = calcOnStack [] rpn operators

calcOnStack :: [Int] -> String -> Operators -> Int
calcOnStack stack []      _         =
  if length stack == 1
    then head stack
    else error "Invalid RPN expression"

calcOnStack stack (x:xs) operators = 
  if isOperator
    then calcOnStack (pop2push stack (snd operator)) xs operators
    else if not $ isDigit x 
            then error $ "Invalid symbol " ++ [x]
            else calcOnStack ((digitToInt x):stack) xs operators
  where operatorWrap = filter (\tpl -> fst tpl == x) operators
        isOperator = not $ null operatorWrap 
        operator = head operatorWrap
                              

