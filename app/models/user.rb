class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :songs, dependent: :destroy
  has_many :messages, through: :songs

  MUSIC_STYLES = ["Pop", "Rock", "Country", "Blues", "Hip-Hop", "Jazz", "World", "Alternative", "R&B", "Folk", "Reggae", "Gospel", "Metal", "Punk"]
  MUSICIAN_TYPES = ["Beginner", "Hobbyist", "Semi-Pro", "Professional", "Virtuoso"]

  validates :username, presence: true, uniqueness: true
  validates :music_style, presence: true, inclusion: { in: MUSIC_STYLES }
  validates :musician_type, presence: true, inclusion: { in: MUSICIAN_TYPES }
  validates :age, presence: true
  validates :gender, presence: true

  after_commit :create_welcome_song, on: :create

  private

  def create_welcome_song
    songs.create!(
      title: "Welcome to LyricLab",
      generated_lyrics: <<~LYRICS.strip,
      Generate Lyrics
      Our AI instantly creates personalized lyrics tailored to your mood, genre, and keywords.
      You can also generate songs from images or chat with LyriBot — then edit, share, or delete them anytime.
      LYRICS
      mood: "Set a Mood - Happy, sad, or energetic — it's up to you.",
      genre: "Choose a Style - Pick Pop, Rock, R&B, Hip-hop, or any genre.",
      keywords: "Add Keywords - Include words or themes you want in your lyrics."
    )
  end
end
