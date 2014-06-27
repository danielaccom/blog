class CommentsController < ApplicationController

	def create
		if user_signed_in?

			@article = Article.find(params[:article_id])
			@comment = @article.comments.new(comment_params)
			@comment.user_id = current_user.id
			@comment.commenter = current_user.email

			if(@comment.article.user_id == current_user.id)
				@comment.approved = 1
			end

			@comment.save
			redirect_to article_path(@article), alert: "Comment created"

			#@article = Article.find(params[:article_id])
			#@comment = @article.comments.create(comment_params)
			#redirect_to article_path(@article)
		else
			redirect_to new_user_session_path, alert: "You are not signed in"
		end

	end

	def destroy
		if user_signed_in?
			
			@article = Article.find(params[:article_id])
			@comment = @article.comments.find(params[:id])

			if @article.user_id == current_user.id
				@comment.destroy
				redirect_to article_path(@article), alert: "comment deleted!"
			else
				if @comment.user_id == current_user.id
					@comment.destroy
					redirect_to article_path(@article), alert: "comment deleted!"
				else
					redirect_to article_path(@article), alert: "you can't delete this comment!"
				end
			end

			#@article = Article.find(params[:article_id])
			#@comment = @article.comments.find(params[:id])
			#@comment.destroy
			#redirect_to article_path(@article)
		else
			redirect_to new_user_session_path
		end

	end

	def update
		unless user_signed_in?
			redirect_to new_user_session_path
		else
			@article = Article.find(params[:article_id])
			@comment = @article.comments.find(params[:id])

			if(@article.user_id == current_user.id)
				@comment.approved = 1
				@comment.save
				redirect_to article_path(@article), alert: "Comment updated!"
			else
				redirect_to article_path(@article), alert: "This is not your comment!"
			end
		end
	end
	
	private
		def comment_params
			params.require(:comment).permit(:commenter,:body)
		end
end
