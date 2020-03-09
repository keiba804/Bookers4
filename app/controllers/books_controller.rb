class BooksController < ApplicationController
	before_action :authenticate_user!, except:[:top, :about]
	before_action :ensure_correct_user,{only:[:edit, :update,:destroy]}
	def new
		@book = Book.new(user_id: @current_user.id)
	end
	def create
		@book = Book.new(book_params)
		@book.user = current_user
		if @book.save
		redirect_to book_path(@book.id), notice: 'Book was successfully created.'
		else
		@user = current_user
		@books = Book.all
		render 'index'
		end
	end
	def index
		@book = Book.new
		@books = Book.all
		@user = current_user
	end
	def show
		@book = Book.find(params[:id])
		@newbook = Book.new
		@user = current_user
	end
	def edit
		@book = Book.find(params[:id])
	end
	def update
		@book = Book.find(params[:id])
	    if @book.update(book_params)
	    	redirect_to book_path(@book.id), notice: 'Book was successfully updated.'
	    else
	    	render 'edit'
	    end
	end
	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end
	def top
	end
	def about
	end
	def ensure_correct_user
	  @book = Book.find(params[:id])
	  if @book.user_id != current_user.id
	  redirect_to books_path
	  end
	end
 private
	def book_params
		params.require(:book).permit(:title, :body)
	end
	def user_params
	    params.require(:user).permit(:name,:introduction,:profile_image,:user_id)
	end
end
