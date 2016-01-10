class ArticlesController < ApplicationController
	#si no has iniciado sesion, te pide que lo hagas
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]
	#GET /articles
	def index
		@articles = Article.all
	end
	#GET /articles/:id
	def show
		@article.update_visits_count
		@comment = Comment.new
	end
	#GET /articles/new
	def new
		@article = Article.new
	end

	def edit

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

		@article.destroy #destroy elimina el objeto dela base de dastos
		redirect_to articles_path
	end
	def update
		if @article.update(article_params)
			redirect_to articles_path
		else
			# lo envia por aqi por si acaso reconoce errores
			render :edit
		end
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end


	def validate_user
		redirect_to new_user_session_path, notice:"Necesitas iniciar sesión"

	end

	def article_params
		#para no seobreescribir, no colocar los sensible
		params.require(:article).permit(:title,:body)

	end
end
