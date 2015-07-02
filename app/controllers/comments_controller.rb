class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(user_id: current_user.id,
                                     body: params[:comment][:body])

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js { render :create }
    end
  end
end
