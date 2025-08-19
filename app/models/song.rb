class Song < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  def build_prompt
    prompt = <<~PROMPT
      You are a lyrical genius who can compose songs with just any prompts
      I am a #{user.musician_type} at #{user.music_style} music
      Help me compose a song with these prompts
      Mood of the song : #{mood}
      Genre of the song : #{genre}
      Keywords of the song : #{keywords}
      Provide the title and the lyrics of the song composed in a JSON format with only two keys "title" and "lyrics"
    PROMPT
  end

end
