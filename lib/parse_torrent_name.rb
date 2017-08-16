require 'ostruct'

class ParseTorrentName
  # Pattern should contain either none or two capturing groups.
  # In case of two groups - 1st is raw, 2nd is clean.
  PATTERNS = {
    season: /([Ss]?([0-9]{1,2}))[Eex]/,
    episode: /([Eex]([0-9]{2})(?:[^0-9]|$))/,
    year: /([\[\(]?((?:19[0-9]|20[01])[0-9])[\]\)]?)/,
    resolution: /(([0-9]{3,4}p))[^M]/,
    quality: /(?:PPV\.)?[HP]DTV|(?:HD)?CAM|B[rR]Rip|TS|(?:PPV )?WEB-?DL(?: DVDRip)?|H[dD]Rip|DVDRip|DVDRiP|DVDRIP|CamRip|W[EB]B[rR]ip|[Bb]lu[Rr]ay|DvDScr|hdtv/,
    codec: /xvid|x264|h\.?264/i,
    audio: /MP3|DD5\.?1|Dual[\- ]Audio|LiNE|DTS|AAC(?:\.?2\.0)?|AC3(?:\.5\.1)?/,
    group: /(- ?([^-]+(?:-={[^-]+-?$)?))$/,
    region: /R[0-9]/,
    extended: /EXTENDED/,
    hardcoded: /HC/,
    proper: /PROPER/,
    repack: /REPACK/,
    container: /MKV|AVI/,
    widescreen: /WS/,
    website: /^(\[ ?([^\]]+?) ?\])/,
    language: /rus\.eng/,
    garbage: /1400Mb|3rd Nov| ((Rip))/,
  }.freeze
  TYPES = {
    season: :integer,
    episode: :integer,
    year: :integer,
    extended: :boolean,
    hardcoded: :boolean,
    proper: :boolean,
    repack: :boolean,
    widescreen: :boolean
  }

  def self.parse(name)
    new(name).parse
  end

  def initialize(name)
    @name = name
    @parts = {}

    @start = 0
    @end = nil

    @raw = name.dup
    @group_raw = ''
    @map = nil
  end

  def parse
    PATTERNS.each do |key, pat|
      next  unless (match = pat.match(@name))

      index = OpenStruct.new(
        raw:   match[1] ? 1 : 0,
        clean: match[1] ? 2 : 0
      )

      if TYPES[key] == :boolean
        clean = true
      else
        clean = match[index.clean]
        if TYPES[key] == :integer
          clean = clean.to_i
        end
      end

      if key == :group
        next  if PATTERNS[:codec].match(clean) || PATTERNS[:quality].match(clean)
        if /[^ ]+ [^ ]+ .+/.match(clean)
          key = :episode_name
        end
      end

      part = OpenStruct.new(
        name: key,
        match: match,
        raw: match[index.raw],
        clean: clean
      )

      if key == :episode
        @map = @name.sub(part.raw, '{episode}')
      end

      on_part(part)
    end

    on_common

    # clean up excess
    clean = @raw.gsub(/(^[-\. ]+)|([-\. ]+$)/, '')
    clean.gsub!(/[\(\)\/]/, ' ')
    clean = clean.split(/\.\.+| +/).reject(&:empty?)

    if clean.any?
      if @name.end_with?(clean[-1] + @group_raw)
        on_late OpenStruct.new(
          name: :group,
          clean: clean.pop + @group_raw
        )
      end

      if @map && clean[0]
        episode_name_re = Regexp.new('{episode}' + Regexp.escape(clean[0].sub(/_+$/, '')))

        if episode_name_re.match(@map)
          on_late OpenStruct.new(
            name: :episode_name,
            clean: clean.shift
          )
        end
      end
    end

    if clean.any?
      on_part OpenStruct.new(
        name: :excess,
        raw: @raw.dup,
        clean: clean.length === 1 ? clean[0] : clean
      )
    end

    @parts
  end

private

  def on_part(part)
    if part.match
      index = part.match.offset(0)[0]
      if index == 0
        @start = part.match[0].length
      elsif !@end || (index < @end)
        @end = index
      end
    end

    if part.name != :excess
      if part.name == :group
        @group_raw = part.raw
      end

      # remove known parts from the excess
      @raw.sub!(part.raw, '')  if part.raw
    end

    @parts[part.name] = part.clean
  end

  def on_common
    raw = @end ? @name[@start...@end].split('(')[0] : @name.dup

    # clean up title
    clean = raw.sub(/^ -/, '')

    if !clean.include?(' ') && clean.include?('.')
      clean.gsub!(/\./, ' ')
    end

    clean.gsub!(/_/, ' ')
    clean = clean.sub(/([\(_]|- )$/, '').strip

    on_part(OpenStruct.new(
      name: :title,
      raw: raw,
      clean: clean
    ))
  end

  def on_late(part)
    if part.name == :group
      on_part(part)

    elsif part.name == :episode_name
      part.clean = part.clean.gsub(/[\._]/, ' ').sub(/_+$/, '').strip
      on_part(part)
    end
  end
end
