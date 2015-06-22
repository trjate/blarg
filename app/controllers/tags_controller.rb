class TagsController < ApplicationController
  def show
    @tag = Tag.find_by!(name: params[:name])
    page = params[:page] || 1
    @posts = @tag.posts.order(written_at: :desc).page(page).per(5)
    render :tagged
  end
end
