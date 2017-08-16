# parse-torrent-name
Parses torrent name of a movie or TV show.

(a Ruby port of the [Javascript library](https://github.com/jzjzjzj/parse-torrent-name) of the same name) 

**Possible parts extracted:**
- audio
- codec
- container
- episode
- episode_name
- excess
- extended
- garbage
- group
- hardcoded
- language
- proper
- quality
- region
- repack
- resolution
- season
- title
- website
- widescreen
- year

## Install:
```ruby
gem 'parse-torrent-name'
```

## Usage:
```ruby
require 'parse-torrent-name'

ParseTorrentName.parse('The.Staying.Alive.S05E02.720p.HDTV.x264-KILLERS[rartv]') =>
{ season: 5,
  episode: 2,
  resolution: '720p',
  quality: 'HDTV',
  codec: 'x264',
  group: 'KILLERS[rartv]',
  title: 'The Staying Alive' }

ParseTorrentName.parse('Captain Russia The Summer Soldier (2014) 1080p BrRip x264 - YIFY') =>
{ year: 2014,
  resolution: '1080p',
  quality: 'BrRip',
  codec: 'x264',
  group: 'YIFY',
  title: 'Captain Russia The Summer Soldier' }

ParseTorrentName.parse('AL.288-1.2014.HC.HDRip.XViD.AC3-juggs[ETRG]') =>
{ year: 2014,
  quality: 'HDRip',
  codec: 'XViD',
  audio: 'AC3',
  group: 'juggs[ETRG]',
  hardcoded: true,
  title: 'AL 288-1' }
```
