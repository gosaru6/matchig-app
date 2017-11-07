class ConversationsController < ApplicationController
  before_action :current_user_check


  def index
    #全てのユーザーと会話一覧を取得
    @users = User.all
    @conversations = Conversation.all
  end

  def create
        #該当ユーザー間での会話が過去に存在しているかを確認する式
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      #存在した場合は⬇で会話を取得
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      #過去に１件も存在しなかった場合、⬇で強制的にメッセージを作成
      @conversation = Conversation.create!(conversation_params)
    end
    #いずれの状態であってもその後その会話に紐づくメッセージ一覧画面へ遷移させる式
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
