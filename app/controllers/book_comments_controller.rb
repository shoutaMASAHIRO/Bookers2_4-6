class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(comment_params)
    @comment.book_id = @book.id
  
    respond_to do |format|
      if @comment.save
        format.js   # JavaScript用
        format.html { redirect_to book_path(@book), notice: "コメントを投稿しました" }
      else
        format.js { render js: "alert('コメントの投稿に失敗しました');" }
        format.html { redirect_to book_path(@book), alert: "コメントの投稿に失敗しました" }
      end
    end
  end
  

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:book_comment).permit(:comment)
  end
end
