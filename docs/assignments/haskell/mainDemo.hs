-- mainDemo.hs

import System.Random (randomRIO)

--
-- Compile this file using ghc as follows:
--
-- $ ghc mainDemo.hs
-- [1 of 1] Compiling Main             ( mainDemo.hs, mainDemo.o )
-- Linking mainDemo ...
--
--
-- $ ./mainDemo
-- Hello!
-- This is a sample Haskell program.
--

--
-- Based on code in this answer:
-- https://stackoverflow.com/questions/30740366/list-with-random-numbers-in-haskell
--
-- randomList and randomListPairs must be used inside a do-environment as
-- shown in main.
--
randomList :: Int -> IO([Int])
randomList 0 = return []
randomList n = do r  <- randomRIO (1,10000)
                  rs <- randomList (n-1)
                  return (r:rs) 

randomListPairs :: Int -> IO([(Int,Int)])
randomListPairs 0 = return []
randomListPairs n = do a <- randomRIO (1,10000)
                       b <- randomRIO (1,10000)
                       ps <- randomListPairs (n-1)
                       return ((a,b):ps) 

main = do putStrLn "Hello!"
          putStrLn ""
          putStrLn "Here's a list of 5 random numbers:"
          lst <- randomList 5
          putStrLn (show lst)
          putStrLn ""
          putStrLn "Here's a list of 5 random pairs:"
          plst <- randomListPairs 5
          putStrLn (show plst)
