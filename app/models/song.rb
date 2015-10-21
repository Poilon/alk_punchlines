# A song is a title and the lyrics associated
# An artist is linked to the song

# Song
#   title: string
#   lyrics: text
#   artist_id: integer
class Song < ActiveRecord::Base
  belongs_to :artist

  def random_lines
    lyrics_array = lyrics.split("\n").reject do |e|
      e.blank? || e.length < 3
    end
    random_num = rand(lyrics_array.length - 1)
    [lyrics_array[random_num], lyrics_array[random_num + 1]]
  end
end
