class Message < ApplicationRecord
  belongs_to :song
  validates :role, presence: true
  validates :content, presence: true
end
