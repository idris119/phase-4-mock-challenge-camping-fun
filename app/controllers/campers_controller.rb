class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response

    def index
        render json: Camper.all, include:[], status: :ok
    end

    def show
        render json: Camper.find(params[:id]), status: :ok
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper,  include: [], status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_record_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def render_invalid_record_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
    

