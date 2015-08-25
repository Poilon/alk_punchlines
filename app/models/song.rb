class Song < ActiveRecord::Base
  belongs_to :artist

  def random_lines
    lyrics_array = lyrics.split("\n").reject do |e|
      e.blank? || e.length < 3
    end
    size = lyrics_array.length
    random_num = rand(size - 1)
    [lyrics_array[random_num], lyrics_array[random_num + 1]]
  end
end
