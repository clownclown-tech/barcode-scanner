class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :destroy, :edit, :update]

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.save
    if @collection.save
      UserCollection.create(user: current_user, collection: @collection, kind: :owner)
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def index
    @user = current_user
    @collections = Collection.joins(:user_collections)
  end

  def show
    @user_collections = UserCollection.where(id: @collection.id)
    @users = User.joins(user_collections: :collection)
    @box = Box.new
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @collection.destroy
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description)
  end

end
