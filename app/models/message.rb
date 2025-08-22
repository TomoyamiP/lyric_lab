class Message < ApplicationRecord
  acts_as_message
  after_create_commit :clean_system_messages

  belongs_to :song
  validates :role, presence: true
  alias_method :chat, :song

  def clean_system_messages
    self.song.messages.where(role: "system").sort_by(&:created_at)[0..-2].each(&:destroy)
  end
end
