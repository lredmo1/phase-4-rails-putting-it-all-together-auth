class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    # before_action :authorize

    def index 
        recipes = Recipe.all
        render json: recipes, status: :ok
    end

    def create
        recipe = Recipe.new(recipe_params)
        recipe.user_id = session[:user_id]
        recipe.save!
        render json: recipe, status: :created
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
    
#   def authorize
#     return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
#   end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end


end
