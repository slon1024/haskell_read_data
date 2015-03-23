{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Data.Aeson
import Control.Applicative
import qualified Data.ByteString.Lazy as B
import GHC.Generics

data Person = Person {   name :: String
                       , email :: String
                       , created_at :: String
                       , is_deleted :: Maybe Int
                       } deriving Generic

instance FromJSON Person

main :: IO ()
main = do
  input <- B.readFile "data/input.json"
  let mm = decode input :: Maybe Person
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn . printPerson) m

printPerson m = (show.name) m ++" has a email: "++ (show.email) m
