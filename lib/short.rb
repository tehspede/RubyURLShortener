require_relative '../models/link'

class Short
  attr_accessor :url, :short
  attr_reader :time

  def initialize
    @short = shorten
    @time = Time.now
  end

  def shorten
    alphabet = ''
    ('a'..'z').each {|x| alphabet += x}

    numbers = ''
    (0..9).each {|x| numbers += x.to_s}

    chars = (alphabet + alphabet.upcase + numbers).split('')

    result = ''

    5.times do
      result += chars[(rand(0...chars.length))]
    end

    result
  end

  def unique_url?
    !Link.exists?(link: @url)
  end

  def unique_short?
    !Link.exists?(short: @short)
  end

  def old_url
    query = Link.find_by short: @short
    query ? query.link : false
  end

  def save
    link = Link.new
    link.link = @url
    link.short = @short
    link.timestamp = @time

    if !unique_short?
      false
    elsif !unique_url?
      @short = (Link.find_by link: @url).short
    else
      link.save
    end
  end
end