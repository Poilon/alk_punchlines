Genius.access_token = ENV['GENIUS_TOKEN']

Artist.create(name: 'Alkpote') unless Artist.find_by_name('Alkpote')
artist = Artist.find_by_name('Alkpote')
songs = Genius::Artist.find(15427).songs(params: { per_page: 50 } )
lyrics_links = songs.map { |e| 'https://www.genius.com' + e.resource['path'] }

lyrics_links.each do |link|
  html = Nokogiri::HTML(HTTParty.get(link))
  Song.create(
    title: html.css('.song_header-primary_info-title').text.strip,
    lyrics: html.css('.lyrics p').text.gsub(/\[.*\]/, ''),
    artist_id: artist.id
  ) unless Song.find_by_title(html.css('.song_header-primary_info-title').text.strip)
end
