class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.comments.create(user_id: current_user.id,
                          body: params[:body])
    redirect_to post_path(@post)
  end
end
