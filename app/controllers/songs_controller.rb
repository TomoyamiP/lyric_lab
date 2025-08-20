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

    case sort_column
    when "date"
      @songs = current_user.songs.order(created_at: sort_direction)
    when "alpha"
      @songs = current_user.songs.order(title: sort_direction)
    else
      @songs = current_user.songs
    end
  end

  def edit
    @song = Song.find(params[:id])
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

  def bulk
    song_ids = Array(params[:song_ids]).reject(&:blank?)

    if song_ids.empty?
      redirect_to songs_path, alert: "Please select at least one song."
      return
    end

    case params[:bulk_action]
    when "edit"
      redirect_to edit_song_path(song_ids.first)
    when "share"
      redirect_to share_song_path(song_ids.first)
    when "delete"
      Song.where(id: song_ids).destroy_all
      redirect_to songs_path, notice: "Selected songs deleted."
    else
      redirect_to songs_path, alert: "Unknown bulk action."
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.user = current_user
    prompt = @song.build_prompt
    AiSongGeneratorService.new(prompt, @song).call
    if @song.save
      redirect_to song_path(@song)
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:mood, :genre, :keywords, :title, :generated_lyrics)
  end
end
