class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  
  def create
    @gram = Gram.find_by_id(params[:gram_id])
    return render_not_found if @gram.blank?
    
    comment = @gram.comments.build(comment_params.merge(user: current_user))
    
    if comment.save
      redirect_to root_path
    else
      flash[:error] = "There was a problem creating your Gram."
      redirect_to root_path
    end
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:message)
    end
  
end