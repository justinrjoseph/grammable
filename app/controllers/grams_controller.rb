class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
  end
  
  def show
    @gram = Gram.find_by_id(params[:id])
    render_not_found if @gram.blank?
  end
  
  def new
    @gram = Gram.new
  end
  
  def create
    @gram = current_user.grams.build(gram_params)
    
    if @gram.save
      redirect_to root_path  
    else
      flash[:error] = "There was a problem creating your Gram."
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @gram = Gram.find_by_id(params[:id])
    render_not_found if @gram.blank?
  end
  
  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    
    if @gram.update_attributes(gram_params)
      redirect_to root_path
    else
      flash[:error] = "There was a problem updating your Gram."
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    
    if @gram.destroy
      redirect_to root_path
    else
      flash[:error] = "There was a problem deleting the Gram."
      redirect_to root_path
    end
  end
  
  private
  
    def gram_params
      params.require(:gram).permit(:message)
    end
    
    def render_not_found
      render text: 'Not Found :(', status: :not_found
    end
  
end
