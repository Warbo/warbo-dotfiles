module Main where

import Control.Lens
import Imm

main = imm myFeeds

-- Feeds are a list of tuples (custom settings, uri)
myFeeds :: [ConfigFeed]
myFeeds = zip (repeat config) myUris

-- Uris are bare String and will be parsed inside imm
myUris =  map snd [

  ("Computing Britain",
   "http://www.bbc.co.uk/programmes/b06bq6j1/episodes/downloads.rss"),

  ("Conor McBride",
   "https://pigworker.wordpress.com/feed/"),

  ("Flying Colours Maths",
   "http://www.flyingcoloursmaths.co.uk/feed/"),

  ("Hidden Histories of the Information Age",
   "http://www.bbc.co.uk/programmes/b04mttrp/episodes/downloads.rss"),

  ("Intelligence: Born Smart, Born Equal, Born Different",
   "http://www.bbc.co.uk/programmes/b042q944/episodes/downloads.rss"),

  ("Lambda the Ultimate",
   "http://lambda-the-ultimate.org/rss.xml")

  ("Linear Digressions",
   "http://feeds.feedburner.com/udacity-linear-digressions"),

  ("MIRI",
   "http://feeds.feedburner.com/miriblog"),

  ("More or Less",
   "http://www.bbc.co.uk/programmes/p02nrss1/episodes/downloads.rss"),

  ("Perry Bible Fellowship",
   "http://pbfcomics.com/feed/feed.xml"),

  ("Planet Haskell",
   "http://planet.haskell.org/rss20.xml"),

  ("Saturday Morning Breakfast Cereal",
   "http://www.smbc-comics.com/rss.php"),

  ("Talking Machines",
   "http://www.thetalkingmachines.com/blog/?format=RSS"),

  ("TED Talks",
   "https://www.ted.com/talks/rss"),

  ("The Life Scientific",
   "http://www.bbc.co.uk/programmes/b015sqc7/episodes/downloads.rss"),

  ("The Math Factor Podcast",
   "http://mathfactor.uark.edu/feed/"),

  ("The Type Theory Podcast",
   "http://typetheorypodcast.com/feed/podcast"),

  ("XKCD",
   "http://xkcd.com/rss.xml"),

  ("XKCD What If",
   "http://what-if.xkcd.com/feed.atom")
  ]

config :: Config -> Config
config = set maildir "/home/chris/.imm-feeds/feeds"
