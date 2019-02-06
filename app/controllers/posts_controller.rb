class PostsController < ApplicationController
  before_action :ensure_login

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @author = User.find(@post.user_id)
    @subs = @post.subs
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
