require 'parse_torrent_name'

RSpec.describe ParseTorrentName do

  it "parses 'The Walking Dead S05E03 720p HDTV x264-ASAP[ettv]'" do
    name = 'The Walking Dead S05E03 720p HDTV x264-ASAP[ettv]'
    expect(described_class.parse(name)).to match(
      title: 'The Walking Dead',
      season: 5,
      episode: 3,
      resolution: '720p',
      quality: 'HDTV',
      codec: 'x264',
      group: 'ASAP[ettv]',
    )
  end

  it "parses 'Marvel's.Agents.of.S.H.I.E.L.D.S02E01.Shadows.1080p.WEB-DL.DD5.1'" do
    name = "Marvel's.Agents.of.S.H.I.E.L.D.S02E01.Shadows.1080p.WEB-DL.DD5.1"
    expect(described_class.parse(name)).to match(
      title: 'Marvel\'s Agents of S H I E L D',
      season: 2,
      episode: 1,
      episode_name: 'Shadows',
      group: 'DL.DD5.1',
      quality: 'WEB-DL',
      resolution: '1080p',
      audio: 'DD5.1',
    )
  end

  Files = [
    {
      name: 'Hercules (2014) 1080p BrRip H264 - YIFY',
      title: 'Hercules',
      year: 2014,
      resolution: '1080p',
      quality: 'BrRip',
      codec: 'H264',
      group: 'YIFY'
    },
    {
      name: 'Dawn.of.the.Planet.of.the.Apes.2014.HDRip.XViD-EVO',
      title: 'Dawn of the Planet of the Apes',
      year: 2014,
      quality: 'HDRip',
      codec: 'XViD',
      group: 'EVO'
    },
    {
      name: 'The Big Bang Theory S08E06 HDTV XviD-LOL [eztv]',
      season: 8,
      episode: 6,
      quality: 'HDTV',
      codec: 'XviD',
      group: 'LOL [eztv]'
    },
    {
      name: '22 Jump Street (2014) 720p BrRip x264 - YIFY',
      title: '22 Jump Street',
    },
    {
      name: 'Hercules.2014.EXTENDED.1080p.WEB-DL.DD5.1.H264-RARBG',
      extended: true,
      quality: 'WEB-DL',
      audio: 'DD5.1',
    },
    {
      name: 'Hercules.2014.EXTENDED.HDRip.XViD-juggs[ETRG]',
      extended: true,
    },
    {
      name: 'Hercules (2014) WEBDL DVDRip XviD-MAX',
      quality: 'WEBDL DVDRip',
    },
    {
      name: 'WWE Hell in a Cell 2014 PPV WEB-DL x264-WD -={SPARROW}=-',
      quality: 'PPV WEB-DL',
      group: 'WD -={SPARROW}=-',
    },
    {
      name: 'UFC.179.PPV.HDTV.x264-Ebi[rartv]',
      title: 'UFC 179',
      quality: 'PPV.HDTV'
    },
    {
      name: 'Marvels Agents of S H I E L D S02E05 HDTV x264-KILLERS [eztv]',
      title: 'Marvels Agents of S H I E L D'
    },
    {
      name: 'X-Men.Days.of.Future.Past.2014.1080p.WEB-DL.DD5.1.H264-RARBG',
      title: 'X-Men Days of Future Past'
    },
    {
      name: 'Guardians Of The Galaxy 2014 R6 720p HDCAM x264-JYK',
      region: 'R6',
      quality: 'HDCAM'
    },
    {
      name: 'Marvels Agents of S.H.I.E.L.D. S02E06 HDTV x264-KILLERS[ettv]',
      title: 'Marvels Agents of S.H.I.E.L.D.'
    },
    {
      name: 'Guardians of the Galaxy (CamRip / 2014)',
    },
    {
      name: 'The.Walking.Dead.S05E03.1080p.WEB-DL.DD5.1.H.264-Cyphanix[rartv]',
      codec: 'H.264',
    },
    {
      name: 'Brave.2012.R5.DVDRip.XViD.LiNE-UNiQUE',
      region: 'R5',
      audio: 'LiNE',
    },
    {
      name: 'Lets.Be.Cops.2014.BRRip.XViD-juggs[ETRG]',
      quality: 'BRRip'
    },
    {
      name: 'These.Final.Hours.2013.WBBRip XViD',
      quality: 'WBBRip'
    },
    {
      name: 'Downton Abbey 5x06 HDTV x264-FoV [eztv]',
      title: 'Downton Abbey',
      season: 5,
      episode: 6,
    },
    {
      name: 'Annabelle.2014.HC.HDRip.XViD.AC3-juggs[ETRG]',
      hardcoded: true,
      audio: 'AC3',
    },
    {
      name: 'Lucy.2014.HC.HDRip.XViD-juggs[ETRG]',
      hardcoded: true,
    },
    {
      name: 'The Flash 2014 S01E04 HDTV x264-FUM[ettv]',
    },
    {
      name: 'South Park S18E05 HDTV x264-KILLERS [eztv]',
    },
    {
      name: 'The Flash 2014 S01E03 HDTV x264-LOL[ettv]',
    },
    {
      name: 'The Flash 2014 S01E01 HDTV x264-LOL[ettv]',
    },
    {
      name: 'Lucy 2014 Dual-Audio WEBRip 1400Mb',
      audio: 'Dual-Audio',
      garbage: '1400Mb',
    },
    {
      name: 'Teenage Mutant Ninja Turtles (HdRip / 2014)',
      title: 'Teenage Mutant Ninja Turtles',
      quality: 'HdRip'
    },
    {
      name: 'Teenage Mutant Ninja Turtles (unknown_release_type / 2014)',
      excess: 'unknown_release_type',
    },
    {
      name: 'The Simpsons S26E05 HDTV x264 PROPER-LOL [eztv]',
      proper: true,
    },
    {
      name: '2047 - Sights of Death (2014) 720p BrRip x264 - YIFY',
      title: '2047 - Sights of Death',
      year: 2014,
    },
    {
      name: 'Two and a Half Men S12E01 HDTV x264 REPACK-LOL [eztv]',
      repack: true,
    },
    {
      name: 'Dinosaur 13 2014 WEBrip XviD AC3 MiLLENiUM',
      quality: 'WEBrip',
      audio: 'AC3',
      group: 'MiLLENiUM',
    },
    {
      name: 'Teenage.Mutant.Ninja.Turtles.2014.HDRip.XviD.MP3-RARBG',
      audio: 'MP3',
    },
    {
      name: 'Dawn.Of.The.Planet.of.The.Apes.2014.1080p.WEB-DL.DD51.H264-RARBG',
      audio: 'DD51',
    },
    {
      name: 'Teenage.Mutant.Ninja.Turtles.2014.720p.HDRip.x264.AC3.5.1-RARBG',
      audio: 'AC3.5.1',
    },
    {
      name: 'Gotham.S01E05.Viper.WEB-DL.x264.AAC',
      episode_name: 'Viper',
      audio: 'AAC',
    },
    {
      name: 'Into.The.Storm.2014.1080p.WEB-DL.AAC2.0.H264-RARBG',
      audio: 'AAC2.0',
    },
    {
      name: 'Lucy 2014 Dual-Audio 720p WEBRip',
      audio: 'Dual-Audio',
    },
    {
      name: 'Into The Storm 2014 1080p BRRip x264 DTS-JYK',
      audio: 'DTS',
    },
    {
      name: 'Sin.City.A.Dame.to.Kill.For.2014.1080p.BluRay.x264-SPARKS',
      quality: 'BluRay'
    },
    {
      name: 'WWE Monday Night Raw 3rd Nov 2014 HDTV x264-Sir Paul',
      title: 'WWE Monday Night Raw',
      garbage: '3rd Nov'
    },
    {
      name: 'Jack.And.The.Cuckoo-Clock.Heart.2013.BRRip XViD',
      title: 'Jack And The Cuckoo-Clock Heart',
    },
    {
      name: 'WWE Hell in a Cell 2014 HDTV x264 SNHD',
      group: 'SNHD',
    },
    {
      name: 'Dracula.Untold.2014.TS.XViD.AC3.MrSeeN-SiMPLE',
      group: 'MrSeeN-SiMPLE',
    },
    {
      name: 'The Missing 1x01 Pilot HDTV x264-FoV [eztv]',
      episode_name: 'Pilot',
    },
    {
      name: 'Doctor.Who.2005.8x11.Dark.Water.720p.HDTV.x264-FoV[rartv]',
      season: 8,
      episode: 11,
      episode_name: 'Dark Water',
    },
    {
      name: 'Gotham.S01E07.Penguins.Umbrella.WEB-DL.x264.AAC',
      episode_name: 'Penguins Umbrella',
    },
    {
      name: 'One Shot [2014] DVDRip XViD-ViCKY',
      title: 'One Shot',
    },
    {
      name: 'The Shaukeens 2014 Hindi (1CD) DvDScr x264 AAC...Hon3y',
      quality: 'DvDScr',
      excess: ['Hindi', '1CD']
    },
    {
      name: 'The Shaukeens (2014) 1CD DvDScr Rip x264 [DDR]',
      quality: 'DvDScr',
      garbage: 'Rip',
      group: '[DDR]',
      excess: '1CD'
    },
    {
      name: 'Annabelle.2014.1080p.PROPER.HC.WEBRip.x264.AAC.2.0-RARBG',
      audio: 'AAC.2.0',
      group: 'RARBG'
    },
    {
      name: 'Interstellar (2014) CAM ENG x264 AAC-CPG',
      quality: 'CAM',
      excess: 'ENG'
    },
    {
      name: 'Guardians of the Galaxy (2014) Dual Audio DVDRip AVI',
      audio: 'Dual Audio',
      container: 'AVI',
    },
    {
      name: 'Eliza Graves (2014) Dual Audio WEB-DL 720p MKV x264',
      container: 'MKV',
    },
    {
      name: 'WWE Monday Night Raw 2014 11 10 WS PDTV x264-RKOFAN1990 -={SPARR',
      widescreen: true,
      quality: 'PDTV',
      group: 'RKOFAN1990 -={SPARR',
      excess: ['11', '10']
    },
    {
      name: 'Sons.of.Anarchy.S01E03',
      title: 'Sons of Anarchy',
      season: 1,
      episode: 3,
    },
    {
      name: 'doctor_who_2005.8x12.death_in_heaven.720p_hdtv_x264-fov',
      title: 'doctor who',
      episode_name: 'death in heaven',
      quality: 'hdtv',
    },
    {
      name: 'breaking.bad.s01e01.720p.bluray.x264-reward',
      title: 'breaking bad',
      season: 1,
      episode: 1,
      quality: 'bluray',
    },
    {
      name: 'Game of Thrones - 4x03 - Breaker of Chains',
      title: 'Game of Thrones',
      episode_name: 'Breaker of Chains',
    },
    {
      name: '[720pMkv.Com]_sons.of.anarchy.s05e10.480p.BluRay.x264-GAnGSteR',
      website: '720pMkv.Com',
      title: 'sons of anarchy',
      season: 5,
      episode: 10,
      resolution: '480p',
      quality: 'BluRay',
      codec: 'x264',
      group: 'GAnGSteR',
    },
    {
      name: '[ www.Speed.cd ] -Sons.of.Anarchy.S07E07.720p.HDTV.X264-DIMENSION',
      website: 'www.Speed.cd',
      title: 'Sons of Anarchy',
      season: 7,
      episode: 7,
      resolution: '720p',
      quality: 'HDTV',
      codec: 'X264',
      group: 'DIMENSION'
    },
    {
      name: 'Community.s02e20.rus.eng.720p.Kybik.v.Kybe',
      title: 'Community',
      season: 2,
      episode: 20,
      language: 'rus.eng',
      resolution: '720p',
      group: 'Kybik.v.Kybe',
    }
  ]

  Files.each do |file|
    it "parses #{file[:name]}" do
      name = file.delete(:name)
      info = ParseTorrentName.new(name).parse
      expect(info).to include file
    end
  end
end
