class MessagesController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    @message = Message.new(message_params)
    @message.song = @song
    @message.role = "user"
    # ai request
    if @message.valid?
      @song.with_instructions(@song.chat_prompt).ask(@message.content)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to edit_song_path(@song) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { chat: @chat, message: @message }) }
        format.html { render "songs/edit" }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
