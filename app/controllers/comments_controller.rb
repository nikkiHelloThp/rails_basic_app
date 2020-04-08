class CommentsController < ApplicationController
	before_action :set_comment, only: %i[edit update destroy]
	before_action :get_gossip, 	only: %i[create update destroy]

	def new
	end

	def create
		comment = Comment.new(body: params[:body], author: current_user)
		comment.commentable_id =
			params[:comment_id] ? params[:comment_id] : params[:gossip_id]
		comment.commentable_type =
		  params[:comment_id] ? 'Comment' : 'Gossip'
		if comment.save
			flash[:success] = "Commentaire cree avec success!"
		else
			flash.now[:danger] = "#{comment.errors.full_messages[0]}"
		end
		redirect_to gossip_path(@gossip)
	end

	def edit
	end

	def update
		if @comment.update(body: params[:body])
			flash[:success] = "Commentaire modifie avec success!"
			redirect_to gossip_path(@gossip)
		else
			flash.now[:danger] = "#{@comment.errors.full_messages[0]}"
			render :edit
		end
	end

	def destroy
		if @comment.destroy
			flash[:success] = "Commentaire supprime avec success!"
			redirect_to gossip_path(@gossip)
		else
			flash.now[:danger] = "#{@comment.errors.full_messages[0]}"
			render :delele
		end
	end


	private

	def get_gossip
		@gossip = Gossip.find_by(id: params[:gossip_id])
	end

	def set_comment
		@comment = Comment.find(params[:id])
	end
end