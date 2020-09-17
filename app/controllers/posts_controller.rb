class PostsController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    @posts = current_user.posts.all
  end

  def show
    @posts = current_user.posts.all
  end

  def new
    @post = Post.new
  end

  def create
    @posts = Post.new(post_params)
    if @posts.save!
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'posts/index'
    end
  end

  def edit
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy #destroyメソッドを使用し対象のツイートを削除する。
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :buyday, :price).merge(user_id: current_user.id)
  end
end
