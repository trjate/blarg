class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :delete]

  def index
    page = params[:page] || 1
    @posts = Post.order(written_at: :desc).page(page).per(5)
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    params = post_params.merge({written_at: DateTime.now})
    @post = current_user.posts.create(params)
    redirect_to posts_path
    # redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.update(post_params)
    else
      flash[:alert] = 'Only the author of a post may change the post.'
    end
    redirect_to post_path(@post)
  end

  def delete
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
    else
      flash[:alert] = 'Only the author of a post may delete a post.'
    end
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :tag_names, :content)
  end

  def invalid_param?
    params[:post].count > post_params.count
  end
end
