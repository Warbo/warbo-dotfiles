#!/usr/bin/env runhaskell

import Data.List
import System.IO
import System.Random (randomRIO)

{-
stdin should have the following format:

M1:s1.d1 foo
M2:s2.d2 bar

Where M1, M2, etc. are minutes; s1, s2, etc. are seconds; d1, d2, etc. are
fractions of a second; and foo and bar are script names.

This script will return a randomly chosen script name, chosen such that
its expected runtime is the average of all the possibilities. In other words,
if foo takes twice as long as bar, it will be half as likely to be returned.

This is useful for re-running tests, for example periodically choosing a test
to re-run, such that we don't spend most of our time stuck in slow tests.
-}

main :: IO ()
main = do sin <- getContents
          x   <- choose sin
          putStrLn x

choose :: String -> IO String
choose sin = let hs = map asHundredths (filter (not . null) (lines sin))
                 ps = probs hs
              in do r <- randomRIO (0.0, 1.0)
                    return (select r ps)

asHundredths :: String -> (Int, String)
asHundredths x = let (t, s) = split ' ' x
                  in (toHundredths t, s)

-- Turn minutes:seconds.hundredths into hundredths
toHundredths :: String -> Int
toHundredths x = let (m, rest) = split ':' x
                     (s, h)    = split '.' rest
                     mI = read m :: Int
                     mS = read s :: Int
                     mH = read h :: Int
                  in 6000 * mI + 100 * mS + mH

split c x = let (pre, post) = break (== c) x
             in (pre, tail post)

total :: [(Int, a)] -> Int
total []          = 0
total ((x, _):xs) = x + total xs

{-
For tests taking time t(1), t(2), ..., we give test i probability:

  p(i) = 1 / (t(i) * sum(j, 1 / t(j)))

If we give each test i a weight w(i) = $TOTAL * p(i), then they will sum to
$TOTAL (modulo rounding errors), which we can manipulate nicely with integers
-}

probs :: [(Int, a)] -> [(Float, a)]
probs hs = map prob' hs
  where t = total hs
        j = sum (map (\(x, _) -> 1 / fromIntegral x) hs)
        prob' (x, y) = let p = 1 / (fromIntegral x * j)
                        in (p, y)

select :: Float -> [(Float, a)] -> a
select r = go 0
  where go _   [(_, x)]    = x
        go acc ((p, x):xs) = if p + acc > r
                                then x
                                else go (p + acc) xs

{-
FACTOR=$(( TOTAL /  ))
PROBS=$(while read -r LINE
        do
            H=$(echo "$LINE" | cut -f 1)
            P=$(( TOTAL  ))
        done < <(echo "$HSECS"))

int random = arc4random()%(int)max;
int currentValue = 0;

for(Apple *apple in array)
        {
            currentValue += (int)(apple.probability * 100.f);
            if(random <= currentValue)
              return apple;
        }

echo "$TOTAL"
-}
