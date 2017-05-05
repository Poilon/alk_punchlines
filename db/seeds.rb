Genius.access_token = ENV['GENIUS_TOKEN']

[14_388, 15_427, 1286].each do |artist_genius_id|
  name = Genius::Artist.find(artist_genius_id).name
  Artist.create(name: name) unless Artist.find_by(name: name)
  artist = Artist.find_by(name: name)
  songs = Genius::Artist.find(artist_genius_id).songs(params: { per_page: 50 })
  lyrics_links = songs.map { |e| 'https://www.genius.com' + e.resource['path'] }

  lyrics_links.each do |link|
    html = Nokogiri::HTML(HTTParty.get(link))
    title_selector = '.song_header-primary_info-title'
    next if Song.find_by_title(html.css(title_selector).text.strip)
    puts html.css(title_selector).text.strip
    Song.create(
      title: html.css('.song_header-primary_info-title').text.strip,
      lyrics: html.css('.lyrics p').text.gsub(/\[.*\]/, ''),
      artist_id: artist.id
    )
  end
end
