class CommentsController < ApplicationController

	def create
		if user_signed_in?

			@article = current_user.articles.find(params[:article_id])
			@comment = @article.comments.create(comment_params)
			redirect_to article_path(@article)

			#@article = Article.find(params[:article_id])
			#@comment = @article.comments.create(comment_params)
			#redirect_to article_path(@article)
		else
			redirect_to new_user_session_path
		end

	end

	def destroy
		if user_signed_in?
			
			@article = current_user.articles.find(params[:article_id])
			@comment = @article.comments.find(params[:id])

			unless @comment.blank?
				@comment.destroy
				redirect_to article_path(@article)
			else
				puts 'this is not your comments'
			end

			#@article = Article.find(params[:article_id])
			#@comment = @article.comments.find(params[:id])
			#@comment.destroy
			#redirect_to article_path(@article)
		else
			redirect_to new_user_session_path
		end

	end
	
	private
		def comment_params
			params.require(:comment).permit(:commenter,:body)
		end
end
