class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @grams = Gram.all
  end
  
  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
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
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
  end
  
  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
    
    if @gram.user != current_user
      return render text: 'Forbidden :(', status: :forbidden
    end
    
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
    return render_not_found(:forbidden) if @gram.user != current_user
    
    if @gram.destroy
      redirect_to root_path
    else
      flash[:error] = "There was a problem deleting the Gram."
      redirect_to root_path
    end
  end
  
  private
  
    def gram_params
      params.require(:gram).permit(:message, :picture)
    end
  
end