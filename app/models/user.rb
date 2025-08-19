class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :songs, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :music_style, presence: true, inclusion: { in: ["Pop", "Rock", "Country", "Blues", "Hip-Hop", "Jazz", "World", "Alternative", "R&B", "Folk", "Reggae", "Gospel", "Metal", "Punk"] }
  validates :musician_type, presence: true, inclusion: { in: ["Beginner", "Hobbyist", "Semi-Pro", "Professional", "Virtuoso"] }
  validates :age, presence: true
  validates :gender, presence: true
end
