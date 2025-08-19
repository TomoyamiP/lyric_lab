class AiSongGeneratorService
  def initialize(prompt, song)
    @prompt = prompt
    @song = song
  end

  def call
    response = RubyLLM.chat.ask(@prompt).content
    response_hash = JSON.parse(response.gsub(/(`|json)/,''))
    @song.title = response_hash["title"]
    @song.generated_lyrics = response_hash["lyrics"]
  end
end
