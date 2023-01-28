class MessagesController < ApplicationController
  before_action :set_group, only: %i[ show create edit update destroy ]
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages/1 or /messages/1.json
  def show
    @message = @group.messages
  end

  def new
    @message = @group.messages.new
  end

  # POST /messages or /messages.json
  def create
    @message = @group.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to group_path(@message.group) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@message, partial: 'messages/form', locals: { message: @message }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(book_params)
        format.html { redirect_to root_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @group.messages.destroy

    respond_to do |format|
      format.html { redirect_to group_path(@message.group), notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:title)
    end
end
