# frozen_literal: true

class CarbonService
  attr_reader :origin, :destination, :transport_mode, :public_transport_mode
  private :origin, :destination, :transport_mode, :public_transport_mode

  def initialize(origin:, destination:, transport_mode:, public_transport_mode:)
    @origin = origin
    @destination = destination
    @transport_mode = transport_mode
    @public_transport_mode = public_transport_mode
  end

  def self.calculate_co2_kgs(origin:, destination:, transport_mode:, public_transport_mode:)
    new(
      origin: origin,
      destination: destination,
      transport_mode: transport_mode,
      public_transport_mode: public_transport_mode
    ).calculate_co2_kgs
  end

  def calculate_co2_kgs
    (direction_distance * average_co2_grams_per_km) / 1000
  end

  private

  def average_co2_grams_per_km
    AverageCo2.co2_grams_per_km(
      transport_mode: transport_mode,
      public_transport_mode: public_transport_mode
    )
  end

  def direction_distance
    direction.routes.first.legs.first.distance_in_km
  end

  def direction
    @direction ||= ::GoogleMaps::Direction.results(
      origin: origin,
      destination: destination,
      transport_mode: transport_mode,
      public_transport_mode: public_transport_mode
    )
  end
end
