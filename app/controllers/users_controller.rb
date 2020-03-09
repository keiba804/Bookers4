class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,{only:[:edit]}
  def show
	@user = User.find(params[:id])
	@books = @user.books
	@book = Book.new
  end
  def edit
  	@user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	redirect_to user_path(@user.id), notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end
  def index
	@book = Book.new
	@users = User.all
	@user = current_user
  end
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user)
    end
  end

  private
  def user_params
  params.require(:user).permit(:name,:email,:introduction,:profile_image,:user_id)
  end
  def book_params
  params.require(:Book).permit(:title, :body)
  end
end
