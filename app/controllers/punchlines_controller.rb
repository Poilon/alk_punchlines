class PunchlinesController < ApplicationController
  def index
    song = Song.order('RANDOM()').first
    @artist = song.try(:artist)
    @random_lines = song.try(:random_lines)
  end
end
