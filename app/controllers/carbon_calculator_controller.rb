# frozen_literal: true

class CarbonCalculatorController < ApplicationController

  def index
  end

  def calculate
    render json: {
      co2_in_kg: CarbonService.calculate_co2_kgs(
        origin: origin,
        destination: destination,
        mode: mode
      )
    }
  end

  private

  def filtered_params
    params.require(:carbon_calculator).permit(
      :origin,
      :destination,
      :mode
    )
  end

  def origin
    filtered_params.fetch(:origin)
  end

  def destination
    filtered_params.fetch(:destination)
  end

  def mode
    filtered_params.fetch(:mode)
  end
end
