# Controller of the /punchlines route
class PunchlinesController < ApplicationController
  def index
    @song = Song.order('RANDOM()').first
    @random_line_num = @song.random_line_num
    @random_lines = @song.try(:find_lyrics, @random_line_num)
    @title = @song.try(:title)
    @artist = @song.try(:artist)
  end

  def show
    if (song = Song.find_by_id(params[:id].split('-').first))
      @random_line_num = params[:id].split('-').last.to_i
      @random_lines = song.try(:find_lyrics, @random_line_num)
      @title = song.try(:title)
      @artist = song.try(:artist)
    else
      render :song_not_found
    end
  end
end
