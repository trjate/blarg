class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :delete]

  def index
    page = params[:page] || 1
    @posts = Post.order(written_at: :desc).page(page).per(5)
    render :index
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.create(title: params[:title],
                                      content: params[:content],
                                      written_at: DateTime.now,
                                      tag_names: params[:tag_names])
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
      @post.update(title: params[:title],
                   content: params[:content],
                   tag_names: params[:tag_names])
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
end
