class TopicsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @topics = Topic.all
  end
  
  def new
    @topic = Topic.new
  end

  def create
    #Topic.create(topics_params)
    @topic = Topic.new(topics_params) #newメソッドで、空のインスタンスを作成し、値を代入した上で保存する。
    if @topic.save
     redirect_to topics_path, notice: "トピックを作成しました！"
    else
     render 'new'
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    @topic.update(topics_params)
    redirect_to topics_path, notice: "トピックを更新しました！"
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path, notice: "トピックを削除しました！"
  end
  
  private
    def topics_params
      params.require(:topic).permit(:title, :content)
    end
    
  # idをキーとして値を取得するメソッド
    def set_blog
      @topic = Topic.find(params[:id])
    end  
    
end
