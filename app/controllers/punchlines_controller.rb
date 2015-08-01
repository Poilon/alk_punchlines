class PunchlinesController < ApplicationController
  def index
    song = Song.order('RANDOM()').first
    if song
      lyrics_array = song.lyrics.split("\n").reject{|e| e.blank? || e.length < 10}
      @artist = song.artist
      size = lyrics_array.length
      random_num = rand(size - 2)
      random_num += 1 if random_num.odd?
      random_line = lyrics_array[random_num]
      random_next_line = lyrics_array[random_num + 1]
      @punchline = (random_line + '<br>' + random_next_line).html_safe
    end
  end
end
