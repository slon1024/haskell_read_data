{-# LANGUAGE OverloadedStrings #-}

import qualified Aws
import qualified Aws.S3 as S3
import           Data.Conduit (($$+-))
import           Data.Conduit.Binary (sinkFile)
import           Network.HTTP.Conduit (withManager, responseBody)

main :: IO ()
main = do
  cfg <- Aws.baseConfiguration
  let s3cfg = Aws.defServiceConfig :: S3.S3Configuration Aws.NormalQuery

  withManager $ \mgr -> do
    S3.GetObjectResponse { S3.gorResponse = rsp } <-
      Aws.pureAws cfg s3cfg mgr $
        S3.getObject "haskell-aws" "cloud-remote.pdf"

    responseBody rsp $$+- sinkFile "cloud-remote.pdf"
