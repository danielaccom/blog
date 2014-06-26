class ArticlesController < ApplicationController

	def index
		if user_signed_in?
			@articles = current_user.articles
		else
			@articles = Article.all
		end
	end

	def new
		if user_signed_in?
			@article = Article.new
		else
			redirect_to new_user_session_path
		end
	end

	def create
		@article = current_user.articles.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		if user_signed_in?
			@article = current_user.articles.find(params[:id])
			if @article.blank?
				redirect_to new_user_session_path
			end
		else
			redirect_to new_user_session_path
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		if user_signed_in?
			@article = current_user.articles.find(params[:id])
			if @article.blank?
				redirect_to new_user_session_path
			end
			@article.destroy
			redirect_to articles_path
		else
			redirect_to new_user_session_path
		end

	end


	private
		def article_params
			params.require(:article).permit(:title, :text)
		end

end