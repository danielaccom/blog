class ArticlesController < ApplicationController

	def index
		#if user_signed_in?
			#@articles = current_user.articles
		#else
			@articles = Article.all
		#end
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
		@article.user_id = current_user.id

		if @article.save
			redirect_to @article, alert: "article created"
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
		
	end

	def edit
		if user_signed_in?
			@article = Article.find(params[:id])
			unless @article.user_id == current_user.id
				redirect_to Article , alert: "you can only edit your own article"
			end
		else
			redirect_to new_user_session_path
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article, alert: "article updated"
		else
			render 'edit'
		end
	end

	def destroy
		if user_signed_in?
			@article = Article.find(params[:id])
			notices = "this is not your article"
			if @article.user_id == current_user.id
				@article.destroy
				notices = "article destroyed"
			end

			redirect_to articles_path, alert: notices
		else
			redirect_to new_user_session_path, alert: "you are not signed in"
		end

	end


	private
		def article_params
			params.require(:article).permit(:title, :text, :avatar)
		end

end