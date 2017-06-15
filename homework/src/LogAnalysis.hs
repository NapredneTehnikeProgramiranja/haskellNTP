{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where

import Data.List.Split(splitOn)
import Log

somefunc :: IO()

somefunc = do
    print (parseMessage "I 9 Back from lunch")
    print (parseMessage "E 99 10 Flange failed!")

parseMessage :: String -> LogMessage
parseMessage x = parseSeverity (splitMessage x)

splitMessage :: String -> [String]
splitMessage x = splitOn " " x 

parseSeverity :: [String] -> LogMessage
parseSeverity [] = Unknown ""
parseSeverity [x] = Unknown x
parseSeverity [x,y] = Unknown (x++y)
parseSeverity (x:y:z:xs) 
    | x == "I" = LogMessage Info (parseTimestamp y) (parseLogMessage (z:xs))
    | x == "W" = LogMessage Warning (parseTimestamp y) (parseLogMessage (z:xs))
    | x == "E" = LogMessage (Error (parseErrorCode y)) (parseTimestamp z) (parseLogMessage xs)
    | otherwise = Unknown (concat (x:y:z:xs))

insertWhitespaces :: [String] -> [String]
insertWhitespaces [] = []
insertWhitespaces [x] = [x]
insertWhitespaces (x: xs) = [x] ++ [" "] ++ insertWhitespaces xs

parseErrorCode :: String -> Int
parseErrorCode code = read code :: Int

parseTimestamp :: String -> TimeStamp
parseTimestamp timestamp = read timestamp ::TimeStamp

parseLogMessage :: [String] -> String
parseLogMessage x = concat (insertWhitespaces x)

parse :: String -> [LogMessage]
parse "" = []
parse log_file = parseLogFile (splitOn "\n" log_file)

parseLogFile :: [String] -> [LogMessage]
parseLogFile [] = []
parseLogFile [x] = [parseMessage x]
parseLogFile (x:xs) = [parseMessage x] ++ parseLogFile xs