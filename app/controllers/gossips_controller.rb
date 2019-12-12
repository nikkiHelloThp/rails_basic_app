class GossipsController < ApplicationController
	before_action :authenticate_user, only: [:show, :new]
	before_action :authenticate_creator, only: [:edit, :update, :destroy]

	def index
		@gossips = Gossip.includes(:likes, :comments).all
		@tags = Tag.all
	end

	def show
		@gossip = Gossip.find(params[:id])
		@comments = @gossip.comments
		#@tag = Tag.find(@gossip.tag_id).name
	end

	def new
		@tags = Tag.all
	end

	def create
		if logged_in?
			gossip = Gossip.new(
								  title: params[:title],
								  body: params[:body],
								  author_id: current_user.id,
								  tag_id: Tag.find_by(name: params[:tag]).id
							  )
			if gossip.save
				flash[:success] = "Gossip creer avec success!"
				redirect_to gossips_path
			else
				flash.now[:danger] = "#{gossip.errors.full_messages[0]}"
				render :new
			end
		end
	end

	def edit
		@gossip = Gossip.find(params[:id])
		@tags = Tag.all
	end

	def update
		@tag = Tag.find_by(name: params[:tag]).id
		@gossip = Gossip.find(params[:id])
		if @gossip.update(title: params[:title], body: params[:body], tag_id: @tag)
			flash[:success] = "Gossip modifie avec success!"
			redirect_to gossips_path
		else
			flash.now[:danger] = "#{@gossip.errors.full_messages[0]}"
			render :edit
		end
	end

	def destroy
		@gossip = Gossip.find(params[:id])
		if @gossip.destroy
			flash[:success] = "Gossip supprime avec success!"
			redirect_to gossips_path
		else
			flash.now[:danger] = "#{@gossip.errors.full_messages[0]}"
			render :delele
		end
	end


	private

	def authenticate_user
		unless current_user
			flash[:danger] = "Connectez-vous d'abord!"
			redirect_to new_session_path
		end
	end

	def authenticate_creator
		@gossip = Gossip.find(params[:id])
		unless current_user == @gossip.author
			flash[:danger] = "Cette action n'est pas disponible!"
			redirect_to gossip_path
		end
	end

end
