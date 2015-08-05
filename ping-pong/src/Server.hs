{-# LANGUAGE OverloadedStrings #-}
module Server
  where

import qualified Data.Conduit.Binary as CB

import Conduit
import Control.Monad (when)
import Data.ByteString (ByteString)
import Data.Conduit.Network
import Data.Word8 (_cr)


runServer
  :: Int
  -> IO ()
runServer port =
  runTCPServer (serverSettings port "*") $ \client ->
       appSource client
    $= CB.lines
    $= filterCE (/= _cr)
    $$ awaitForever $ \msg ->
        when (msg == "ping") $
             yield "pong\n"
          $$ appSink client
