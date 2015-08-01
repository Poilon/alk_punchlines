
Artist.create(name: 'Alkpote') unless Artist.find_by_name('Alkpote')
artist = Artist.find_by_name('Alkpote')

songs = `curl -d 'name=Alkpote' -d 'genre=rap' 'http://genius-api.com/api/artistInfo'`
songs.insert(0, '[')
songs << ']'

song_names = JSON.parse(songs)

lyrics_links = song_names.first['songs'].map{|e| e['link'].gsub('http://rapgenius.com', '')}


lyrics_links.each do |link|
  html = Nokogiri::HTML(HTTParty.get(link))
  Song.create(
    title: html.css('.text_title').text.strip,
    lyrics: html.css('.lyrics p').text.gsub(/\[.*\]/, ''),
    artist_id: artist.id
  ) unless Song.find_by_title(html.css('.text_title').text.strip)
end
