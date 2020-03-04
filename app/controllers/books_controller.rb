class BooksController < ApplicationController
	def new
		@book = Book.new
	end
	def create
		@book = Book.new(book_params)
		@book = current_user.id
		if book.save
			redirect_to book_path
		else
			render :new
		end
	end
	def index
		@book = Book.new
		@books = Book.all
	end
	def show
		@book = Book.find(paramd[:id])
	end
	def edit
	end
	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end
	def top
	end
private
	def Book_params
		params.require(:Book).permit(:name, :introduction)
	end
end
