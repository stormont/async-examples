{-# LANGUAGE OverloadedStrings #-}
module Client
  where

import Conduit
import Control.Concurrent.Async (concurrently)
import Control.Monad (void)
import Data.Conduit.Network


runClient
  :: Int
  -> IO ()
runClient port =
  runTCPClient (clientSettings port "localhost") $ \server ->
    void $ concurrently
      (appSource server $$ stdoutC)
      (stdinC $$ appSink server)
