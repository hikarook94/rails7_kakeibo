class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = '家計簿にデータを１件登録しました。'
      redirect_to books_path
    else
      flash.now[:alert] = '登録に失敗しました。'
      render :new, status: :unprocessable_entity 
      # status: :unprocessable_entity をつけないとバリデーション失敗時のエラーメッセージが表示されない。
      # https://qiita.com/jnchito/items/5c41a7031404c313da1f#%E3%83%90%E3%83%AA%E3%83%87%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E5%A4%B1%E6%95%97%E6%99%82%E3%81%AB-status-unprocessable_entity-%E3%82%92%E4%BB%98%E3%81%91%E3%82%8B%E5%BF%85%E8%A6%81%E3%81%8C%E3%81%82%E3%82%8B
    end
  end

  def edit
  end

  def update
    book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
    if @book.update(book_params)
      flash[:notice] = 'データを１件更新しました。'
      redirect_to books_path
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = '削除しました。'
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

end
