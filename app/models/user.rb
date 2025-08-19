class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :songs, dependent: :destroy

  MUSIC_STYLES = ["Pop", "Rock", "Country", "Blues", "Hip-Hop", "Jazz", "World", "Alternative", "R&B", "Folk", "Reggae", "Gospel", "Metal", "Punk"]
  MUSICIAN_TYPES = ["Beginner", "Hobbyist", "Semi-Pro", "Professional", "Virtuoso"]

  validates :username, presence: true, uniqueness: true
  validates :music_style, presence: true, inclusion: { in: MUSIC_STYLES }
  validates :musician_type, presence: true, inclusion: { in: MUSICIAN_TYPES }
  validates :age, presence: true
  validates :gender, presence: true
end
