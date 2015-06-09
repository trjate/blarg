class PostsController < ApplicationController
  def index
    page = params[:page] || 1
    @posts = self.get_page(page)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private
  def get_page(n)
    page_offset = (n - 1) * 10
    Post.order(written_at: :desc).offset(page_offset).limit(10)
  end
end
