{-# LANGUAGE OverloadedStrings #-}
import Data.Aeson
import Control.Applicative
import qualified Data.ByteString.Lazy as B

import Data.Time.Format     (parseTime)
import Data.Time.Clock      (UTCTime)
import System.Locale        (defaultTimeLocale)
import Control.Monad        (liftM)

data Person = Person {
  name :: String,
  email :: String,
  created_at :: Maybe UTCTime,
  is_deleted :: Maybe Int
} deriving (Show)

instance FromJSON Person where
  parseJSON (Object v) = Person
    <$> (v .: "name")
    <*> (v .: "email")
    <*> liftM parseRHTime (v .: "created_at")
    <*> (v .:? "is_deleted")


parseRHTime :: String -> Maybe UTCTime
parseRHTime = parseTime defaultTimeLocale "%FT%X%QZ"

main :: IO ()
main = do
  input <- B.readFile "data/input.json"
  let mm = decode input :: Maybe Person
  case mm of
    Nothing -> print "error parsing JSON"
    Just m -> (putStrLn . printPerson) m

printPerson m = (show.name) m ++" has a email: "++ (show.email) m 
