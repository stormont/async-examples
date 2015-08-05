{-# LANGUAGE OverloadedStrings #-}
module Main
  where

import Lib
import System.Environment (getArgs)

main :: IO ()
main = do
  [port] <- getArgs
  runClient (read port)
