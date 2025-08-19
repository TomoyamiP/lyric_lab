class SongsController < ApplicationController
  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.user = current_user
    prompt = @song.build_prompt
    AiSongGeneratorService.new(prompt, @song).call
    raise
    if @song.save
      redirect_to song_path(@song)
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def song_params
    params.require(:song).permit(:mood, :genre, :keywords)
  end
end
