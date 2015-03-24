import Text.HandsomeSoup
import Text.XML.HXT.Core

main = runX $ fromUrl "http://www.datatau.com" >>> css "td.title a" !"href"
