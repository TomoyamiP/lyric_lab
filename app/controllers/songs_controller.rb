class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: -> { redirect_to songs_path, alert: "Song not found." }
  before_action :set_song, only: [:edit, :update, :destroy]

  def show
    @song = Song.find(params[:id])
  end

  def index
    sort_column = params[:sort]
    sort_direction = params[:direction] == "desc" ? "desc" : "asc"

    @songs = case sort_column
             when "date"
               current_user.songs.order(created_at: sort_direction)
             when "alpha"
               current_user.songs.order(title: sort_direction)
             else
               current_user.songs
             end
  end

  def edit
    @song = Song.find(params[:id])
    @messages = @song.messages
    @message = Message.new
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to songs_path(@song), notice: "Song edited successfully."
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path, status: :see_other, notice: "Song deleted successfully."
  end

  def new
    @song = Song.new
  end

  def create
  @song = Song.new(song_params)
  @song.user = current_user

  if @song.save
    # Combine possible prompt sources
    prompt = @song.build_prompt.presence || @song.keywords.presence

    if @song.photo.attached?
      # Photo alone or photo + prompt
      process_photo(@song.photo, extra_prompt: prompt)
    elsif prompt.present?
      # Prompt only
      send_question(with: { prompt: prompt })
    end

    # Save AI-generated lyrics & title if response exists
    if @response&.content.present?
      response_hash = JSON.parse(@response.content.gsub(/(`|json)/,''))
      @song.generated_lyrics = response_hash['lyrics']
      @song.title ||= response_hash['title'] || "Untitled Song"
      @song.save
    end

    redirect_to song_path(@song)
  else
    render :new, status: :unprocessable_entity
  end
end

# Process attached photo (or PDF) with optional extra prompt
def process_photo(photo, extra_prompt: nil)
  # debugger
  return unless photo.attached?

  # Build input for AI
  input_content = extra_prompt.presence || @song.keywords.presence || "Generate lyrics based on this image."

  # Get public URL
  photo_url = photo.url rescue nil
  unless photo_url
    Rails.logger.error "Cannot generate public URL for photo #{photo.filename}"
    return
  end

  # Choose model based on type
  if photo.content_type == "application/pdf"
    @chat = RubyLLM.chat(model: "gemini-2.0-flash")
    @chat.with_instructions(instructions)
    @response = @chat.ask(input_content, with: { pdf: photo_url })
  elsif photo.image?
    @chat = RubyLLM.chat(model: "gpt-4o") # vision-capable
    @chat.with_instructions(instructions)
    @response = @chat.ask(input_content + "\nAlso use this image as an inspiration", with: { image: photo_url })
  end
end

# Standard AI call without file
def send_question(model: "gpt-4.1-nano", with: {})
  prompt_content = with.delete(:prompt) || @song.keywords.presence || "Generate lyrics."
  @chat = RubyLLM.chat(model: model)
  @response = @chat.with_instructions(instructions).ask(prompt_content, with: with)
end


  def instructions
    "Generate lyrics based on the song keywords and mood."
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:mood, :genre, :keywords, :title, :generated_lyrics, :photo)
  end
end
