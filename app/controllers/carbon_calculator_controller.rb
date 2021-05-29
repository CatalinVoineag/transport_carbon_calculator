# frozen_literal: true

class CarbonCalculatorController < ApplicationController

  def index
  end

  def calculate
    render json: {
      co2_kgs: CarbonService.calculate_co2_kgs(
        origin: origin,
        destination: destination,
        transport_mode: transport_mode,
        public_transport_mode: public_transport_mode
      )
    }
  end

  private

  def filtered_params
    params.require(:carbon_calculator).permit(
      :origin,
      :destination,
      :transport_mode,
      :public_transport_mode
    )
  end

  def origin
    filtered_params.fetch(:origin)
  end

  def destination
    filtered_params.fetch(:destination)
  end

  def transport_mode
    filtered_params.fetch(:transport_mode)
  end

  def public_transport_mode
    filtered_params.fetch(:public_transport_mode)
  end
end
