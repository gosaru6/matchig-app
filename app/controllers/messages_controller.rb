class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages # 会話に紐づくメッセージを取得

    # 新規投稿のメッセージ用の変数を作成する
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    user_email
    if @message.save
      ContactMailer.contact_mail(@recipient_user).deliver
      redirect_to conversation_messages_path(@conversation)
    else
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end

end
