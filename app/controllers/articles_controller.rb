class ArticlesController < ApplicationController
	#GET /articles
	def index
		@articles = Article.all
	end
	#GET /articles/:id
	def show
		@article = Article.find(params[:id])
	end
	#GET /articles/new
	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end
	#POST /articles
	def create
		#insert into
		@article = current_user.articles.new(article_params)
		#si las validaciones pasaron y guarda en DB, redirige
		if @article.save
			redirect_to @article
		else
			#sino renderisa el mismo formulario
			render :new
		end
	end
	#DELETE /articles
	def destroy
		#delete from articles
		@article = Article.find(params[:id])
		@article.destroy #destroy elimina el objeto dela base de dastos
		redirect_to articles_path
	end
	def update
		@article = Article.find(params[:id])		
		if @article.update(article_params)
			redirect_to articles_path
		else
			# lo envia por aqi por si acaso reconoce errores
			render :edit
		end
	end

	private

	def article_params
		#para no seobreescribir, no colocar los sensible
		params.require(:article).permit(:title,:body)
		
	end
end