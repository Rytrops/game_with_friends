module Api
  module V1
    class VideogamesController < ApplicationController
      before_action :set_videogame, only: %i[ show edit update destroy ]

      def index
        videogames = Videogame.all
        render json: VideogameSerializer.new(videogames)
      end

      def show
        videogame = Videogame.find(params[:id])
        render json: VideogameSerializer.new(videogame).serializable_hash.to_json
      end

      def new
        @videogame = Videogame.new
      end

      def edit
      end

      def create
        videogame = Videogame.new(videogame_params)
        
        if videogame.save
          render json: VideogameSerializer.new(videogame).serializable_hash.to_json
        else
          render json: { error: videogame.errors.messages }, status: 422
        end

      end

      def update
     

        videogame = Videogame.find(params[:id])
        
        if videogame.update(videogame_params)
          render json: VideogameSerializer.new(videogame).serializable_hash.to_json
        else
          render json: { error: videogame.errors.messages }, status: 422
        end
      end

      def destroy
        videogame = Videogame.find(params[:id])
        
        if videogame.destroy
          head :no_content
        else
          render json: { error: videogame.errors.messages }, status: 422
        end
      end

      private
      def set_videogame
        @videogame = Videogame.find(params[:id])
      end

      def videogame_params
        params.require(:videogame).permit(:game_name, :developer, :number_of_players)
      end
    end
  end
end
