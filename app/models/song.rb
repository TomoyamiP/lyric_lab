class Song < ApplicationRecord
  acts_as_chat

  belongs_to :user
  has_many :messages, dependent: :destroy

  after_initialize :set_chat

  def set_chat
    @chat = RubyLLM.chat
  end

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

  def chat_prompt
    instructions = <<~INSTRUCTIONS
      You are a lyrical genius who can compose songs with just any prompts
      I am a #{user.musician_type} at #{user.music_style} music
      You helped me compose a song with these prompts
      Mood of the song : #{mood}
      Genre of the song : #{genre}
      Keywords of the song : #{keywords}
      This is the song that you wrote
      Title : #{title}
      Lyrics : #{generated_lyrics}
      I am now trying to edit the song lyrics.
      Separate the paragraphs properly for easy read
    INSTRUCTIONS
  end
end
