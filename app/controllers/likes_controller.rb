class LikesController < ApplicationController

	def create
		# find_by est peut etre meileur

		if logged_in? && Gossip.find(params[:gossip_id]).likes.map { |like| like.author_id }.include?(current_user.id)
			flash.now[:danger] = "Vous avez deja liker ce gossip"
		elsif logged_in?
			like = Like.new(
							 author_id: current_user.id,
							 gossip_id: params[:gossip_id]
						 )
			if like.save
				flash[:success] = "like creer avec success!"
				redirect_to gossips_path
			end
		else
			flash.now[:danger] = "connexion requise avant de liker"
		end
	end

	def destroy
		if logged_in?
			like = Gossip.find(params[:gossip_id]).likes.where(author_id: current_user.id).first
			if !like.nil?
			like.destroy
			flash[:success] = "like supprime avec success"
			redirect_to gossips_path
			end
		end
	end


	private

	# attention la methode create a 2 fois la condition logged_in? donc peut etre un before_action :check_log_in serait plus adapte
end