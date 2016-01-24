class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
  end
  
  def new
    @gram = Gram.new
  end
  
  def create
    @gram = current_user.grams.build(gram_params)
    
    if @gram.save
      redirect_to root_path  
    else
      flash[:error] = "There was a problem posting your Gram."
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
    def gram_params
      params.require(:gram).permit(:message)
    end
  
end
