# frozen_literal: true

class CarbonCalculationsController < ApplicationController

  def index
  end

  def new
  end

  def create
    co2_kgs = CarbonService.calculate_co2_kgs(
      origin: origin,
      destination: destination,
      transport_mode: transport_mode,
      public_transport_mode: public_transport_mode
    )

    puts co2_kgs
    puts co2_kgs
    puts co2_kgs

    redirect_to carbon_calculations_path, notice: 'Calculation successful'
  end

  private

  def filtered_params
    params.require(:carbon_calculations).permit(
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
    filtered_params.fetch(:transport_mode).downcase
  end

  def public_transport_mode
    filtered_params.fetch(:public_transport_mode).downcase
  end
end
