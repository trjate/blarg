class PostsController < ApplicationController
  def view
    @post = Post.find(params[:id])
  end
end
