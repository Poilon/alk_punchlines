# Controller of the /punchlines route
class PunchlinesController < ApplicationController
  def index
    song = Song.order('RANDOM()').first
    @title = song.try(:title)
    @artist = song.try(:artist)
    @random_lines = song.try(:random_lines)
  end
end
