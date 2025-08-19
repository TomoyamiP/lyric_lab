class SongsController < ApplicationController
  before_action :set_song, only: [:edit, :update, :destroy, :share]

  def index
    @songs = Song.all
  end

  def edit
    # @song = Song.find(params[:id])
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

  def share
    if request.get?
      # 显示表单
    elsif request.post?
      recipient_email = params[:recipient_email]
      note = params[:note]

      if recipient_email.present?
        # TODO: 在这里实现分享逻辑（未来可接 Mailer 发邮件）
        redirect_to songs_path, notice: "Song shared with #{recipient_email}."
      else
        flash.now[:alert] = "Email cannot be blank."
        render :share, status: :unprocessable_entity
      end
    end
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :generated_lyrics)
  end
end
