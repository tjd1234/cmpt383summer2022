-- helloWorld.hs

import System.Random (randomRIO)

--
-- Compile this file using ghc as follows:
--
-- $ ghc helloWorld.hs
-- [1 of 1] Compiling Main             ( helloWorld.hs, helloWorld.o )
-- Linking helloWorld ...
--
--
-- $ ./helloWorld
-- Hello!
-- This is a sample Haskell program.
--

--
-- Based on code in this answer:
-- https://stackoverflow.com/questions/30740366/list-with-random-numbers-in-haskell
--
-- randomList must be used inside a do-environment
--
randomList :: Int -> IO([Int])
randomList 0 = return []
randomList n = do r  <- randomRIO (1,6)
                  rs <- randomList (n-1)
                  return (r:rs) 

main = do putStrLn "Hello!"
          putStrLn "This is a sample Haskell program."
          putStrLn "Here's a list of 10 random numbers:"
          lst <- randomList 10
          putStrLn (show lst)
