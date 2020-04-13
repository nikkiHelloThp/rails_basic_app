class GossipsController < ApplicationController
	before_action :set_gossip, only: %i[show edit update destroy]
	before_action :get_tags, only: %i[index new edit update]
	before_action :authenticate_user, only: [:show, :new]
	before_action :authenticate_creator, only: [:edit, :update, :destroy]

	def index
		@gossips = Gossip.includes(:likes, :comments).all
	end

	def show
		@comments = @gossip.comments
		@tag = Tag.find(@gossip.tag_id)
	end

	def new
		@gossip = Gossip.new
	end

	def create
		gossip = current_user.gossips.build(gossip_params)
		if gossip.save
			flash[:success] = "Gossip creer avec success!"
			redirect_to gossip_url(gossip)
		else
			flash.now[:danger] = "#{gossip.errors.full_messages[0]}"
			render :new
		end
	end

	def edit
		# debugger
	end

	def update
		if @gossip.update(gossip_params)
			flash[:success] = "Gossip modifie avec success!"
			redirect_to gossip_url(@gossip)
		else
			flash.now[:danger] = "#{@gossip.errors.full_messages[0]}"
			render :edit
		end
	end

	def destroy
		if @gossip.destroy
			flash[:success] = "Gossip supprime avec success!"
			redirect_to gossips_url
		else
			flash.now[:danger] = "#{@gossip.errors.full_messages[0]}"
		end
	end


	private

	def get_tags
		@tags = Tag.all
	end

	def set_gossip
		@gossip = Gossip.find(params[:id])
		# rescue ActiveRecord::RecordNotFound => e
		# 	flash[:notice] = "#{e}"
		# 	redirect_to root_path
	end

	def gossip_params
		params.require(:gossip).permit(:title, :body, :tag_id)
	end

	def authenticate_creator
		@gossip = Gossip.find(params[:id])
		unless current_user == @gossip.author
			flash[:danger] = "Cette action n'est pas disponible!"
			redirect_to gossip_url
		end
	end

end
