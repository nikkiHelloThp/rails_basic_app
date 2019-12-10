class CommentsController < ApplicationController
	# facultatif puisque gossip[:show] est deja sous influence
	before_action :authenticate_user, only: [:create]

	def new
	end

	def create
		if params[:comment_id]
			@comment = Comment.new(
									 body: params[:body],
									 author_id: current_user.id,
									 commentable_id: params[:comment_id],
									 commentable_type: 'Comment'
								 )
		elsif params[:gossip_id]
			@comment = Comment.new(
									 body: params[:body],
									 author_id: current_user.id,
									 commentable_id: params[:gossip_id],
									 commentable_type: 'Gossip'
								 )
		end

		if @comment.save
			flash[:success] = "Commentaire cree avec success!"
		else
			flash.now[:danger] = "#{@comment.errors.full_messages[0]}"
		end
		redirect_to root_path
		# redirect_to gossip_path(params[:gossip_id])
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		if params[:comment_id]
			@comment = Comment.find(params[:id])
		elsif params[:gossip_id]
			@comment = Comment.find(params[:id])
		end

		if @comment.update(body: params[:body])
			flash[:success] = "Commentaire modifie avec success!"
			redirect_to root_path
			# redirect_to gossip_path(params[:gossip_id])
		else
			flash.now[:danger] = "#{@comment.errors.full_messages[0]}"
			render :edit
		end
	end

	def destroy
		if params[:comment_id]
			@comment = Comment.find(params[:id])
		elsif params[:gossip_id]
			@comment = Comment.find(params[:id])
		end
				
		if @comment.destroy
			flash[:success] = "Commentaire supprime avec success!"
			redirect_to root_path
			# redirect_to gossip_path(params[:gossip_id])
		else
			flash.now[:danger] = "#{@comment.errors.full_messages[0]}"
			render :delele
		end
	end


	private

	def authenticate_user
		unless current_user
			flash[:danger] = "Impossibe de commenter sans etre connecte"
			redirect_to new_session_path
		end
	end
end