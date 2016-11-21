module Main where

import Control.Lens
import Imm
import System.Directory
import System.Environment
import System.IO.Unsafe

main = imm myFeeds

-- Feeds are a list of tuples (custom settings, uri)
myFeeds :: [ConfigFeed]
myFeeds = map (\uri -> (mkConfig uri, uri)) myUris

-- Uris are bare String and will be parsed inside imm
myUris =  map ("http://localhost:8888/" ++) filesInCache

mkConfig :: String -> Config -> Config
mkConfig uri = set maildir ("/home/chris/Mail/feeds/" ++ name)
  where name      = dropPre (dropSuf uri)
        dropPre s = reverse (takeWhile (/= '/') (reverse s))
        dropSuf s = reverse (tail (dropWhile (/= '.') (reverse s)))

isRss = (".rss" `isSuffixOf`)

filesInCache :: [FilePath]
filesInCache = unsafePerformIO $ do
  rss     <- getDirectoryContents "/home/chris/.cache/rss"
  iplayer <- getDirectoryContents "/home/chris/.cache/iplayer_feeds"
  let rss'     = map           ("rss/" ++) (filter isRss rss)
      iplayer' = map ("iplayer_feeds/" ++) (filter isRss iplayer)
  return (rss' ++ iplayer')
