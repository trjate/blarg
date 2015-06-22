class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :delete]

  def index
    page = params[:page] || 1
    @posts = Post.order(written_at: :desc).page(page).per(5)
    render :index
  end

  def tagged
    @tag = Tag.find_by(name: params[:name])
    page = params[:page] || 1
    if @tag
      @posts = @tag.posts.order(written_at: :desc).page(page).per(5)
      render :tagged
    else
      flash[:notice] = "No posts tagged with #{params[:name]}."
      redirect_to :root
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    @action = posts_path
    @http_verb = :post
    render :new
  end

  def create
    tags = params[:tags].split(", ")
    tag_models = tags.map { |tag| Tag.find_or_create_by(name: tag) }
    @post = current_user.posts.create(title: params[:title],
                                      content: params[:content],
                                      written_at: DateTime.now,
                                      tags: tag_models)
    redirect_to posts_path
    # redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.map(&:name).join(", ")
    # @tags = @post.tags.map { |x| x.name }.join(", ")
    @action = post_path(@post)
    @http_verb = :patch
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      tags = params[:tags].split(", ")
      tag_models = tags.map { |tag| Tag.find_or_create_by(name: tag) }
      @post.update(title: params[:title],
                   content: params[:content],
                   tags: tag_models)
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
