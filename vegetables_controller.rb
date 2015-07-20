class VegetablesController < ApplicationController

  #Vegetable instead of Vegetables, since the Model is singular
  def index
    @vegetables = Vegetable.all
  end

  def show
    @vegetable = Vegetable.find(params[:id])
  end

  def new
    @vegetable = Vegetable.new
  end

  def create
    @vegetable = Vegetable.new(whitelisted_vegetable_params)
    if @vegetable.save
      flash[:success] = "That sounds like a tasty vegetable!"
      redirect_to @vegetable
    else
      flash.now[:error] = "Aww, that veggie wasn't created."
      render :new
    end
    #should be part of if/else statement, also can just re-render and not lose the info already written and potential helpful error msgs
    # redirect_to :new #render :new
  end

  def edit
    #only needs id here to find this model instance
    @vegetable = Vegetable.find(params[:id])
  end

  def update
    #do not need a new vegetable instance, just find the one that's updating
    @vegetable = Vegetable.find(params[:id])
    if @vegetable.update(whitelisted_vegetable_params) #needs the params here
      flash[:success] = "A new twist on an old favorite!"
      redirect_to @vegetable
    else
      #needs a flash.now to show up now and not the next pg
      flash.now[:error] = "Something is rotten here..."
      render :edit
    end
  end

  def destroy  #not delete
    @vegetable = Vegetable.find(params[:id])
    #I'll just add an if/else statement with flash msg in case of errors
    if @vegetable.destroy
      flash[:success] = "That veggie is trashed."
      # redirect_to @vegetable  #it was deleted!!! won't exist
      redirect_to vegetables_path #the index
    else
      flash.now[:error] = "It's a weed! That veggie is still there and not trashed yet."
      render :edit
    end
  end

  private

  def whitelisted_vegetable_params
    #incorrect format
    #require(:vegetable).permit(:name, :color, :rating, :latin_name)
    params.require(:vegetable).permit(:name, :color, :rating, :latin_name)
  end

end
