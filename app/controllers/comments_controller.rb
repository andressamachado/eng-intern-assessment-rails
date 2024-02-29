# frozen_string_literal: true

# Controller for the comments resource
class CommentsController < ApplicationController
  before_action :set_article

  # POST /articles/:article_id/comments
  # Create a new Comment instance and save it to the database.
  def create
    @comment = @article.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(article_url(@article), notice: "Comment added!") }
        format.json { render(:show, status: :created, location: @article) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @comment.errors, status: :unprocessable_entity) }
      end
    end
  end

  # GET /articles/:article_id/comments/:id/edit
  # Populate the form with the comment's current data from database.
  def edit
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
  end

  # DELETE /articles/:article_id/comments/:id
  # Delete a Comment instance from the database.
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to(article_path(@article), notice: "Comment deleted!")
  end

  # PATCH/PUT /articles/:article_id/comments/:id
  # Update a Comment instance in the database.
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to(article_url(@article), notice: "comment successfully updated!") }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @article.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:article_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    if Current.user.nil?
      params.require(:comment).permit(:username, :body, :article_id)
    else
      params.require(:comment).permit(:username, :body, :article_id).merge(username: Current.user.username)
    end
  end
end
