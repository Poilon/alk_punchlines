Genius.access_token = ENV['GENIUS_TOKEN']

[14_388, 15_427, 1286, 335_710].each do |artist_genius_id|
  name = Genius::Artist.find(artist_genius_id).name
  Artist.create(name: name) unless Artist.find_by(name: name)
  artist = Artist.find_by(name: name)

  100.times do |i|
    songs = Genius::Artist.find(artist_genius_id).songs(params: { per_page: 50, page: i + 1 })
    break if songs.blank?
    lyrics_links = songs.map { |e| 'https://www.genius.com' + e.resource['path'] }

    lyrics_links.each do |link|
      html = Nokogiri::HTML(HTTParty.get(link))
      title_selector = '.song_header-primary_info-title'
      puts html.css(title_selector).text.strip
      next if Song.find_by_title(html.css(title_selector).text.strip)
      Song.create(
        title: html.css('.song_header-primary_info-title').text.strip,
        lyrics: html.css('.lyrics p').text.gsub(/\[.*\]/, ''),
        artist_id: artist.id
      )
    end
  end
end
