# A song is a title and the lyrics associated
# An artist is linked to the song

# Song
#   title: string
#   lyrics: text
#   artist_id: integer
class Song < ActiveRecord::Base
  belongs_to :artist

  def random_line_num
    rand(lyrics_array.length - 1)
  end

  def find_lyrics(line_num)
    [lyrics_array[line_num], lyrics_array[line_num + 1]]
  end

  private

  def lyrics_array
    @_lyrics_array = lyrics.split("\n").reject do |e|
      e.blank? || e.length < 3
    end
  end
end
